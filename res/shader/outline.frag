varying vec4 v_fragmentColor; // vertex shader传入，setColor设置的颜色
varying vec2 v_texCoord; // 纹理坐标

uniform float u_outlinePly; // 描边宽度，以像素为单位
uniform vec3 u_outlineColor; // 描边颜色
uniform vec2 u_textureSize; // 纹理大小（宽和高），为了计算周围各点的纹理坐标，必须传入它，因为纹理坐标范围是0~1

const float cosArray[12] = {1, 0.866, 0.5, 0, -0.5, -0.866, -1, -0.866, -0.5, 0, 0.5, 0.866};  
const float sinArray[12] = {0, 0.5, 0.866, 1, 0.866, 0.5, 0, -0.5, -0.866, -1, -0.866, -0.5};

// 判断在这个角度上距离为u_outlinePly那一点是不是透明
int getIsStrokeWithAngelIndex(int index)
{
    int stroke = 0;
    float a = texture2D(CC_Texture0, vec2(v_texCoord.x + u_outlinePly * cosArray[index] / u_textureSize.x, v_texCoord.y + u_outlinePly * sinArray[index] / u_textureSize.y)).a;  
    if (a >= 0.5)
    {
        stroke = 1;
    }
    return stroke;
}

void main()
{
    vec4 myC = texture2D(CC_Texture0, v_texCoord); // 正在处理的这个像素点的颜色
    if (myC.a >= 0.5) // 不透明，直接返回
    {
        gl_FragColor = v_fragmentColor * myC;
        return;
    }

    int strokeCount = 0;
    strokeCount += getIsStrokeWithAngelIndex(0);  
    strokeCount += getIsStrokeWithAngelIndex(1);  
    strokeCount += getIsStrokeWithAngelIndex(2);  
    strokeCount += getIsStrokeWithAngelIndex(3);  
    strokeCount += getIsStrokeWithAngelIndex(4);  
    strokeCount += getIsStrokeWithAngelIndex(5);  
    strokeCount += getIsStrokeWithAngelIndex(6);  
    strokeCount += getIsStrokeWithAngelIndex(7);  
    strokeCount += getIsStrokeWithAngelIndex(8);  
    strokeCount += getIsStrokeWithAngelIndex(9);  
    strokeCount += getIsStrokeWithAngelIndex(10);  
    strokeCount += getIsStrokeWithAngelIndex(11);  
  

    if (strokeCount > 0) // 四周围至少有一个点是不透明的，这个点要设成描边颜色
    {
        myC.rgb = u_outlineColor;
        myC.a = 1.0;
    }

    gl_FragColor = v_fragmentColor * myC;
}