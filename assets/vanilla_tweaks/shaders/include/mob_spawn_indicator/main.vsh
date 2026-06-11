out vec2 mobSpawn_lightLevel;
out vec2 mobSpawn_faceCoords;
out float mobSpawn_stairs;

vec2 mobSpawn_generateFaceCoords() {
    if (gl_VertexID % 4 == 0) return vec2(1.0,0.0);
    else if (gl_VertexID % 4 == 1) return vec2(1.0,1.0);
    else if (gl_VertexID % 4 == 2) return vec2(0.0,1.0);
    else if (gl_VertexID % 4 == 3) return vec2(0.0,0.0);
}

void mobSpawn_main(vec3 positionAttribute, ivec2 lightCoords) {
    if (!(fract(positionAttribute.x) >= 0.7 || fract(positionAttribute.z) >= 0.7) && (fract(positionAttribute.x) > 0.01 || fract(positionAttribute.z) > 0.01)) {
        mobSpawn_stairs = 1.0;
    } else {
        mobSpawn_stairs = 0.0;
    }

    mobSpawn_lightLevel = vec2(lightCoords);

    const vec2[4] corners = vec2[4](
        vec2(0, 1),
        vec2(0, 0),
        vec2(1, 0),
        vec2(1, 1)
    );

    mobSpawn_faceCoords = corners[gl_VertexID % 4];
}
