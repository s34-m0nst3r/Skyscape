//Receive the input positions (x,y,z/depth) of the vertices.
attribute vec3 in_Position;
//Receive the input color (red, green, blue, alpha) of the vertices.
attribute vec4 in_Colour;
//Receive the input texture coordinates (u,v) of the vertices.
//u,v are the x,y of texture coordinates, but called u,v to avoid confusion.
attribute vec2 in_TextureCoord;

//Pass the texture coordinates to the fragment shader.
varying vec2 v_vTexcoord;
//Pass the vertex color/alpha to the fragment shader.
varying vec4 v_vColour;

//Handle vertex.
void main()
{
    //Create a vector for the vertex position and translation amount (1.0).
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    //Output the vertex position (in projection-space).
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;

    //Set the vertex color/alpha to be passed to the fragment shader.
    v_vColour = in_Colour;
    //Set the texture coordinates to be passed to the fragment shader.
    v_vTexcoord = in_TextureCoord;
}