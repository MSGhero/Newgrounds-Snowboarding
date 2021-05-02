# Newgrounds-Snowboarding
The public repo for the Newgrounds Snowboarding game. Please credit the original artists and musicians if you use stuff (the audio tracks have various licensing terms found on Newgrounds, don't just steal!).

![image](https://user-images.githubusercontent.com/5033927/116805727-5fbf9580-aaf6-11eb-89c2-b023c303175e.png)

Check out the game on Newgrounds! https://www.newgrounds.com/portal/view/792154

Development got real game jammy towards the end, so please don't mention how chaotic the code gets.

![image](https://user-images.githubusercontent.com/5033927/116805724-59311e00-aaf6-11eb-8cc9-fdb3d61ce40a.png)

I personally think the shaders in the `graphics/` folder are interesting for people afraid of them. We have a simple "fill with color," FX antialiasing that I stol— I mean utilized, an outline shader, a grind rail (!), scrolling and looping backgrounds, and of course the downhill slope the game centers on. It really highlighted for me what the `drawTriangles()` function is all about: define the areas of the screen you want shaded (with triangles) and define how you want the art stretched and squished (with UVs).

Amid the mess, there are some goodies. With a bit of love, `Animation`, `BitmapButton`, and `BitmapBoolean` could be staples. My `input`/`Actions` code saves the day once again, with some lessons learned for future games.

![image](https://user-images.githubusercontent.com/5033927/116805720-50d8e300-aaf6-11eb-80a9-3c1e9cccbc3f.png)

Let me know what you think, unless it's something that would make me feel bad.
