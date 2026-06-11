in vec2 mobSpawn_lightLevel;
in vec2 mobSpawn_faceCoords;
in float mobSpawn_stairs;

#define MOB_SPAWN_THICKNESS (sqrt(2.0) / 2.0 / 16.0)
#define MOB_SPAWN_OUTLINE ((16.0 - (7.5 * sqrt(2.0))) / 32.0)
#define MOB_SPAWN_CORNER (9.9 / 16.0)

vec4 mobSpawn_modifyColour(vec4 textureColour, vec4 vertexColourVarying) {
    // make sure color is just the raw texture, `texture(Sampler0, texcoord0)` for example
    float lightLevelOpacity = 0.45;

    if (mobSpawn_lightLevel.x <= 1*16+1) {
        lightLevelOpacity = 1;
    } else if (mobSpawn_lightLevel.x <= 7*16+1) {
        lightLevelOpacity = 0.7;
    }

    bool shape = abs(mobSpawn_faceCoords.x + mobSpawn_faceCoords.y - 1) < MOB_SPAWN_THICKNESS || abs(mobSpawn_faceCoords.x - mobSpawn_faceCoords.y) < MOB_SPAWN_THICKNESS;
    bool corners = abs(mobSpawn_faceCoords.x + mobSpawn_faceCoords.y - 1) < (MOB_SPAWN_CORNER * lightLevelOpacity) && abs(mobSpawn_faceCoords.x - mobSpawn_faceCoords.y) < (MOB_SPAWN_CORNER * lightLevelOpacity);

    vec4 vertColour = vertexColourVarying;
    vec4 colour = textureColour;

    if (
        shape && corners && mobSpawn_stairs < (1.0 / 255.0)
        #ifdef ALPHA_CUTOUT
        && textureColour.a > 0.95
        #endif
    ) {
        if (mobSpawn_lightLevel.x <= 1*16+1) {
            colour *= vec4(4.0,0.0,0.0,1.0); //? RED
        } else if (mobSpawn_lightLevel.x <= 7*16+1) {
            colour *= vec4(4.0,1.5,0.0,1.0); //? ORANGE
        } else if (mobSpawn_lightLevel.x <= 11*16+1) {
            colour *= vec4(4.0,4.0,0.0,1.0); //? YELLOW
        } 

        vertColour = mix(vertexColourVarying, vec4(1.), 0.5);
    }

    return clamp(colour * vertColour, 0.0, 1.0);
}