module avr.specs;

version (LDC)
{
	mixin("public import avr.specs.specs_" ~ __traits(targetCPU) ~ ";");
}
else
	static assert(false, "Unable to determine target CPU without LDC");
