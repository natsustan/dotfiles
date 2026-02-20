// Kitty-style cursor tail - adapted from sahaj-b/ghostty-cursor-shaders
// Trail shrinks from previous position toward current position (comet tail effect)

// --- CONFIGURATION ---
vec4 TRAIL_COLOR = vec4(1.0, 0.725, 0.161, 1.0); // #FFB929 yellow
const float DURATION = 0.25; // kitty default decay range: 0.1~0.4s
const float MAX_TRAIL_LENGTH = 0.2;
const float THRESHOLD_MIN_DISTANCE = 1.0;
const float BLUR = 2.0;

// EaseOutCirc
float ease(float x) {
    float t = x - 1.0;
    return sqrt(1.0 - t * t);
}

float getSdfRectangle(in vec2 p, in vec2 xy, in vec2 b) {
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

float seg(in vec2 p, in vec2 a, in vec2 b, inout float s, float d) {
    vec2 e = b - a;
    vec2 w = p - a;
    vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    d = min(d, dot(p - proj, p - proj));

    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float allCond = c0 * c1 * c2;
    float noneCond = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
    s *= mix(1.0, -1.0, step(0.5, allCond + noneCond));
    return d;
}

float getSdfParallelogram(in vec2 p, in vec2 v0, in vec2 v1, in vec2 v2, in vec2 v3) {
    float s = 1.0;
    float d = dot(p - v0, p - v0);
    d = seg(p, v0, v3, s, d);
    d = seg(p, v1, v0, s, d);
    d = seg(p, v2, v1, s, d);
    d = seg(p, v3, v2, s, d);
    return s * sqrt(d);
}

vec2 normalize(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

float antialising(float distance) {
    return 1.0 - smoothstep(0.0, normalize(vec2(BLUR), 0.0).x, distance);
}

float determineIfTopRightIsLeading(vec2 a, vec2 b) {
    float c1 = step(b.x, a.x) * step(a.y, b.y);
    float c2 = step(a.x, b.x) * step(b.y, a.y);
    return 1.0 - max(c1, c2);
}

vec2 getRectangleCenter(vec4 rectangle) {
    return vec2(rectangle.x + rectangle.z * 0.5, rectangle.y - rectangle.w * 0.5);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);

    float progress = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);
    if (progress >= 1.0) return;

    vec2 vu = normalize(fragCoord, 1.0);
    vec2 offsetFactor = vec2(-0.5, 0.5);

    vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.0), normalize(iCurrentCursor.zw, 0.0));
    vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.0), normalize(iPreviousCursor.zw, 0.0));

    vec2 centerCC = currentCursor.xy - (currentCursor.zw * offsetFactor);
    vec2 centerCP = previousCursor.xy - (previousCursor.zw * offsetFactor);

    float lineLength = distance(centerCC, centerCP);
    float minDist = currentCursor.w * THRESHOLD_MIN_DISTANCE;

    if (lineLength <= minDist) return;

    vec4 newColor = fragColor;
    float sdfCurrentCursor = getSdfRectangle(vu, centerCC, currentCursor.zw * 0.5);

    // Head/tail animation: head reaches destination first, tail follows (comet effect)
    float tail_delay_factor = MAX_TRAIL_LENGTH / lineLength;
    float isLongMove = step(MAX_TRAIL_LENGTH, lineLength);

    float head_eased = mix(1.0, ease(progress), isLongMove);
    float tail_eased = mix(ease(progress), ease(smoothstep(tail_delay_factor, 1.0, progress)), isLongMove);

    // Detect straight moves for rectangle vs parallelogram
    vec2 delta_abs = abs(centerCC - centerCP);
    float isStraightMove = max(step(delta_abs.y, 0.001), step(delta_abs.x, 0.001));

    // Parallelogram SDF (diagonal moves)
    vec2 head_pos_tl = mix(previousCursor.xy, currentCursor.xy, head_eased);
    vec2 tail_pos_tl = mix(previousCursor.xy, currentCursor.xy, tail_eased);

    float isTopRightLeading = determineIfTopRightIsLeading(currentCursor.xy, previousCursor.xy);
    float isBottomLeftLeading = 1.0 - isTopRightLeading;

    vec2 v0 = vec2(head_pos_tl.x + currentCursor.z * isTopRightLeading, head_pos_tl.y - currentCursor.w);
    vec2 v1 = vec2(head_pos_tl.x + currentCursor.z * isBottomLeftLeading, head_pos_tl.y);
    vec2 v2 = vec2(tail_pos_tl.x + currentCursor.z * isBottomLeftLeading, tail_pos_tl.y);
    vec2 v3 = vec2(tail_pos_tl.x + currentCursor.z * isTopRightLeading, tail_pos_tl.y - previousCursor.w);

    float sdfTrail_diag = getSdfParallelogram(vu, v0, v1, v2, v3);

    // Rectangle SDF (straight moves)
    vec2 head_center = mix(centerCP, centerCC, head_eased);
    vec2 tail_center = mix(centerCP, centerCC, tail_eased);
    vec2 box_center = (min(head_center, tail_center) + max(head_center, tail_center)) * 0.5;
    vec2 box_size = (max(head_center, tail_center) - min(head_center, tail_center)) + currentCursor.zw;

    float sdfTrail_rect = getSdfRectangle(vu, box_center, box_size * 0.5);

    // Select and draw
    float sdfTrail = mix(sdfTrail_diag, sdfTrail_rect, isStraightMove);
    newColor = mix(newColor, TRAIL_COLOR, antialising(sdfTrail));

    // Punch hole for current cursor
    newColor = mix(newColor, fragColor, step(sdfCurrentCursor, 0.0));

    fragColor = newColor;
}
