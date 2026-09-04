CC = gcc
CFLAGS = -Wall -O2 -fPIC
LDFLAGS = -L./sdk/lib -lqmi
INCLUDES = -I./sdk/include

TARGET = libapn_sdk.so
SRCS = apn_sdk.c qmi_core.c apn_parser.c policy_engine.c
OBJS = $(SRCS:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJS)
    $(CC) -shared -o $@ $(OBJS) $(LDFLAGS)

%.o: %.c apn_sdk.h
    $(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

clean:
    rm -f $(OBJS) $(TARGET)

install: $(TARGET)
    cp $(TARGET) /usr/local/lib/
    cp apn_sdk.h /usr/local/include/
