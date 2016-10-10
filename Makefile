#
# gst-shadertoy
#
# This Makefile will download and convert shaders to be used
# with gst-shadertoy-*.sh scripts.
#

all: download-shaders

top_srcdir = $(CURDIR)

SHADER_LIST = $(top_srcdir)/shaders.txt
GEN_SHADER_NAMES = $(top_srcdir)/gen-shader-names
ID_ID_FROM_NAME = $(top_srcdir)/shader-id-from-name
DL_SHADER = $(top_srcdir)/st-dl-shader
SHADER_NAMES = $(shell $(GEN_SHADER_NAMES) $(SHADER_LIST) )
SHADER_FILES = $(addsuffix .fs,$(SHADER_NAMES))

%.fs:
	$(DL_SHADER) $(shell $(ID_ID_FROM_NAME) $(SHADER_LIST) $(@:.fs=)) > $@

.PHONY: download-shaders
download-shaders: $(SHADER_FILES)

.PHONY: clean
clean:
	rm -f $(SHADER_FILES)
