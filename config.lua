

application =
{
	content =
	{
    --getting current device width, height
		width = display.contentWidth,
		height = display.contentHeight,
		scale = "adaptive",
		fps = 60,
		xalign = "center",
		yalign = "top",

		imageSuffix = 
		{
      ["@2x"] = 1.5,
      ["@4x"] = 4.0,
		}
	}
}