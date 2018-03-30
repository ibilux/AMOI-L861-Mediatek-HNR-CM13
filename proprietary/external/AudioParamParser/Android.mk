LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

ifeq ($(strip $(MTK_APP_FORCE_ENABLE_CUS_XML_SUPPORT)),yes)
	LOCAL_CFLAGS += APP_FORCE_ENABLE_CUS_XML
endif

ifeq ($(strip $(TARGET_BUILD_VARIANT)),eng)
	LOCAL_CFLAGS += -DCONFIG_MT_ENG_BUILD
endif

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES:= \
	AudioCategory.c \
	AudioParam.c \
	AudioParamFieldInfo.c \
	AudioParamParser.c \
	AudioParamTreeView.c \
	AudioParamUnit.c \
	AudioType.c \
	AudioUtils.c \
	UnitTest.c \
	guicon.cpp

LOCAL_C_INCLUDES := \
	external/libxml2/include \
	external/icu/icu4c/source/common \
    $(MTK_PATH_CUSTOM)/cgen/inc \
    $(MTK_PATH_CUSTOM)/cgen/cfgfileinc \
    $(MTK_PATH_CUSTOM)/cgen/cfgdefault \
	$(JNI_H_INCLUDE) \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/../audiocustparam

LOCAL_SHARED_LIBRARIES += \
	libicuuc \
	libutils \
	libcutils \
	libbinder \
	libmedia \
	libaudiocustparam

LOCAL_STATIC_LIBRARIES := libxml2

LOCAL_MODULE := libaudio_param_parser

LOCAL_MULTILIB := both

include $(BUILD_SHARED_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := eng

LOCAL_SRC_FILES:= \
	test/main.c

LOCAL_C_INCLUDES= \
	$(LOCAL_PATH)../AudioParamParser/ \
	$(LOCAL_PATH)../AudioParamParser/include

LOCAL_SHARED_LIBRARIES += \
	libaudio_param_parser

LOCAL_MODULE := audio_param_test

#LOCAL_MULTILIB := 32

include $(BUILD_EXECUTABLE)

include $(LOCAL_PATH)/DeployAudioParam.mk

include $(LOCAL_PATH)/GenAudioParamOptionsXml.mk

