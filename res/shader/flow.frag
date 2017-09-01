#ifdef GL_ES
precision mediump float;
#endif
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;

uniform sampler2D u_texture;
uniform float factor;
uniform float speed;
uniform float radian;

void main(void) {
	vec4 texColor = texture2D(CC_Texture0, v_texCoord);

	vec2 offset = vec2(0.0, 0.0);
	float offsetX = (v_texCoord[0] + v_texCoord[1] * tan(radian)) / 2.0 - CC_Time[1] * speed;
	while (offsetX < 0.0) {
		offsetX = offsetX + 1.0;
	}
	offset[0] = offsetX;
	offset[1] = v_texCoord[1];
	vec4 texLight = texture2D(u_texture, offset);

	float alpha = texColor[3] * texLight[3];
	texColor[0] = texColor[0] + texLight[0] * alpha * factor;
	texColor[1] = texColor[1] + texLight[1] * alpha * factor;
	texColor[2] = texColor[2] + texLight[2] * alpha * factor;
	gl_FragColor = texColor * v_fragmentColor;
}