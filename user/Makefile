
PROGS=litepcie_util litepcie_test
BUILD_DIR=../build/user

CFLAGS=-O2 -Wall -g -I../kernel -Iliblitepcie -fPIC
LDFLAGS=-g
DEPFLAGS=-MMD -MF $(BUILD_DIR)
CC=$(CROSS_COMPILE)gcc
AR=ar


LIB_SRC=$(wildcard liblitepcie/*.c)
LIB_OBJS=$(patsubst %.c,$(BUILD_DIR)/%.o,$(LIB_SRC))

default: all

all: $(PROGS)

$(BUILD_DIR)/liblitepcie/liblitepcie.a: $(LIB_OBJS)
	ar rcs $@ $+
	ranlib $@

litepcie_util: $(BUILD_DIR)/litepcie_util.o $(BUILD_DIR)/liblitepcie/liblitepcie.a
	$(CC) $(LDFLAGS) -o $(BUILD_DIR)/$@ $< -L$(BUILD_DIR)/liblitepcie -llitepcie

litepcie_test: $(BUILD_DIR)/litepcie_test.o $(BUILD_DIR)/liblitepcie/liblitepcie.a
	$(CC) $(LDFLAGS) -o $(BUILD_DIR)/$@ $< -L$(BUILD_DIR)/liblitepcie -lm -llitepcie

clean:
	rm -rf $(BUILD_DIR)/*.o $(BUILD_DIR)/litepcie_util $(BUILD_DIR)/litepcie_test
	rm -rf $(BUILD_DIR)/liblitepcie

$(BUILD_DIR)/%.o: %.c
	$(V) mkdir -p $(BUILD_DIR)
	$(CC) -c $(CFLAGS) $(DEPFLAGS)/$*.d -o $@ $<

$(LIB_OBJS): $(BUILD_DIR)/liblitepcie/%.o: liblitepcie/%.c
	$(V) mkdir -p $(BUILD_DIR)/liblitepcie
	$(CC) -c $(CFLAGS) $(DEPFLAGS)/liblitepcie/$*.d -o $@ $<

-include $(wildcard $(BUILD_DIR)/*.d)