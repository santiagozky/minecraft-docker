#!/bin/bash
lines=$(curl https://www.minecraft.net/en-us/download/server/bedrock)
#example url https://minecraft.azureedge.net/bin-linux/bedrock-server-1.16.210.06.zip
regex="https://minecraft.azureedge.net/bin-linux/(bedrock-server-(.*)).zip"
for f in $lines    # unquoted in order to allow the glob to expand
do
    if [[ $f =~ $regex ]]
    then
        url="${BASH_REMATCH[0]}"
        echo "${url}"    # concatenate strings
        name="bedrock_server.zip"    # same thing stored in a variable
	wget $url -O $name
	unzip $name -d bedrock
	rm bedrock_server.zip
    fi
done
