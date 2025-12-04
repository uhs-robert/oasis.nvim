# Making the Social Preview

## Setup

The social preview must be uploaded to the [repository's settings](https://github.com/uhs-robert/oasis.nvim/settings).

Use the [index.html](./index.html) to create an image for screenshot capture.

Just open it up in a browser and make sure the images in [images](./images/) are up to date.

## Regenerating the HTML

`index.html` is generated from the Oasis palettes. To rebuild it (defaults to lagoon dark):

```bash
lua assets/socials/generate_social_preview.lua [palette] [mode]
# e.g. lua assets/socials/generate_social_preview.lua lagoon dark
```

Drop a matching `./images/<palette>-code.png` if you switch the hero palette.

## Making an Image for Code

1. Open a screenshot of a code file in `GIMP`
2. Go to `Crop`, select whole image
3. Set Size: `990`, `595`
4. Set Position: `38`, `120`
5. Click cropped image to trigger resize
6. Export as as `png`

## Making an Image for Dashbaord

1. Open a screenshot of a code file in `GIMP`
2. Go to `Crop`, select whole image
3. Set Size: `1070`, `528`
4. Set Position: `100`, `200`
5. Click cropped image to trigger resize
6. Export as as `png`

> [!TIP]
> If numbers won't apply: [BACKSPACE] out the field, type in the new number, and then hit [ENTER]
