# Newgrounds-Snowboarding
The public repo for the Newgrounds Snowboarding game

Check out the game on Newgrounds! https://www.newgrounds.com/portal/view/792154

Development got real game jammy towards the end, so please don't mention how chaotic the code gets.

I personally think the shaders in the `graphics/` folder are interesting for people afraid of them. We have a simple "fill with color," FX antialiasing that I stol— I mean utilized, an outline shader, a grind rail (!), scrolling and looping backgrounds, and of course the downhill slope the game centers on. It really highlighted for me what the `drawTriangles()` function is all about: define the areas of the screen you want shaded (with triangles) and define how you want the art stretched and squished (with UVs).

Amid the mess, there are some goodies. With a bit of love, `Animation`, `BitmapButton`, and `BitmapBoolean` could be staples. My `input`/`Actions` code saves the day once again, with some lessons learned for future games.

Let me know what you think, unless it's something that would make me feel bad.