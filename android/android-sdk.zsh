# -*- mode: shell-script; -*-

if [[ $(uname) == 'Darwin' ]] then

	android_sdk_path="$(/usr/local/bin/brew --prefix android-sdk)"
	android_ndk_path="$(/usr/local/bin/brew --prefix android-ndk)"

	if [ -d "$android_sdk_path" ]
	then
		export ANDROID_HOME="$android_sdk_path"
		export ANDROID_SDK="$android_sdk_path"
	fi

	if [ -d "$android_ndk_path" ]
	then
		export ANDROID_NDK="$android_ndk_path"
	fi

fi
