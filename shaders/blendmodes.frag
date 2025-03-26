//Darken
vec3 darken (vec3 target, vec3 blend){
    
 return min (target, blend);   
}

//Multiply
vec3 multiply (vec3 target, vec3 blend){
    return target*blend;
}

//Color Burn
vec3 colorBurn (vec3 target, vec3 blend){
    return 1.0 - (1.0 - target)/ blend;
}

//Linear Burn
vec3 linearBurn (vec3 target, vec3 blend){
    return target + blend - 1.0;
}

//Lighten
vec3 lighten (vec3 target, vec3 blend){
    return max (target, blend);
}

//Screen
vec3 screen (vec3 target, vec3 blend){
    return 1.0 - (1.0 - target) * (1.0 - blend);
}

//Color Dodge
vec3 colorDodge (vec3 target, vec3 blend){
    return target / (1.0 - blend);
}

//Linear Dodge
vec3 linearDodge (vec3 target, vec3 blend){
    return target + blend;
}

//Overlay
vec3 overlay (vec3 target, vec3 blend){
    vec3 temp;
    temp.x = (target.x > 0.5) ? (1.0-(1.0-2.0*(target.x-0.5))*(1.0-blend.x)) : (2.0*target.x)*blend.x;
    temp.y = (target.y > 0.5) ? (1.0-(1.0-2.0*(target.y-0.5))*(1.0-blend.y)) : (2.0*target.y)*blend.y;
    temp.z = (target.z > 0.5) ? (1.0-(1.0-2.0*(target.z-0.5))*(1.0-blend.z)) : (2.0*target.z)*blend.z;
    return temp;
}

//Soft Light
vec3 softLight (vec3 target, vec3 blend){
 vec3 temp;
    temp.x = (blend.x > 0.5) ? (1.0-(1.0-target.x)*(1.0-(blend.x-0.5))) : (target.x * (blend.x + 0.5));
    temp.y = (blend.y > 0.5) ? (1.0-(1.0-target.y)*(1.0-(blend.y-0.5))) : (target.y * (blend.y + 0.5));
    temp.z = (blend.z > 0.5) ? (1.0-(1.0-target.z)*(1.0-(blend.z-0.5))) : (target.z * (blend.z + 0.5));
    return temp;   
}

//Hard Light
vec3 hardLight (vec3 target, vec3 blend){
    vec3 temp;
    temp.x = (blend.x > 0.5) ? (1.0-(1.0-target.x)*(1.0-2.0*(blend.x-0.5))) : (target.x * (2.0*blend.x));
    temp.y = (blend.y > 0.5) ? (1.0-(1.0-target.y)*(1.0-2.0*(blend.y-0.5))) : (target.y * (2.0*blend.y));
    temp.z = (blend.z > 0.5) ? (1.0-(1.0-target.z)*(1.0-2.0*(blend.z-0.5))) : (target.z * (2.0*blend.z));
    return temp;
}

//Vivid Light
vec3 vividLight (vec3 target, vec3 blend){
     vec3 temp;
    temp.x = (blend.x > 0.5) ? (1.0-(1.0-target.x)/(2.0*(blend.x-0.5))) : (target.x / (1.0-2.0*blend.x));
    temp.y = (blend.y > 0.5) ? (1.0-(1.0-target.y)/(2.0*(blend.y-0.5))) : (target.y / (1.0-2.0*blend.y));
    temp.z = (blend.z > 0.5) ? (1.0-(1.0-target.z)/(2.0*(blend.z-0.5))) : (target.z / (1.0-2.0*blend.z));
    return temp;
}

//Linear Light
vec3 linearLight (vec3 target, vec3 blend){
    vec3 temp;
    temp.x = (blend.x > 0.5) ? (target.x)+(2.0*(blend.x-0.5)) : (target.x +(2.0*blend.x-1.0));
    temp.y = (blend.y > 0.5) ? (target.y)+(2.0*(blend.y-0.5)) : (target.y +(2.0*blend.y-1.0));
    temp.z = (blend.z > 0.5) ? (target.z)+(2.0*(blend.z-0.5)) : (target.z +(2.0*blend.z-1.0));
    return temp;
}

//Pin Light
vec3 pinLight (vec3 target, vec3 blend){
     vec3 temp;
    temp.x = (blend.x > 0.5) ? (max (target.x, 2.0*(blend.x-0.5))) : (min(target.x, 2.0*blend.x));
    temp.y = (blend.y > 0.5) ? (max (target.y, 2.0*(blend.y-0.5))) : (min(target.y, 2.0*blend.y));
    temp.z = (blend.z > 0.5) ? (max (target.z, 2.0*(blend.z-0.5))) : (min(target.z, 2.0*blend.z));
    return temp;
}

//Difference
vec3 difference (vec3 target, vec3 blend){
    return abs (target - blend);
    
}
//Exclusion
vec3 exclusion (vec3 target, vec3 blend){
    return 0.5 - 2.0*(target-0.5)*(blend-0.5);
    
}

//Subtract (thanks to Brandondorf9999)
vec3 subtract (vec3 target, vec3 blend){
    return target - blend;
}

//Divide (thanks to Brandondorf9999)
vec3 divide (vec3 target, vec3 blend){
 return target/blend;   
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = openfl_TextureCoordv;
	
	//upper texture
	vec3 upperTexture = texture2D(iChannel0, uv).xyz;
	
	//lower texture
	vec3 lowerTexture = texture2D(iChannel1, uv).xyz;
    
    vec3 finalImage = vec3(0.0);
    else if (time==4) finalImage =lighten ( upperTexture,  lowerTexture);
    
    //set the color
    fragColor = vec4(finalImage, 1.0);
}