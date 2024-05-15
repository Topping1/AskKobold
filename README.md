# AskKobold: KoboldCpp Highlight Plugin for KOReader

This is a fork of AskGPT that modifies the plugin so it works with the KoboldCpp API.

This plugin for KOReader allows you to ask questions about the parts of the book you're reading and receive insightful answers from KoboldCpp API, using the GGUF for the language model of your choice. With AskKobold, you can have a more interactive and engaging reading experience, and gain a deeper understanding of the content.

## Getting Started

To use this plugin, You'll need to do a few things:

- Get [KoReader](https://github.com/koreader/koreader) installed on your e-reader. You can find instructions for doing this for a variety of devices [here](https://www.mobileread.com/forums/forumdisplay.php?f=276).

- If you want to do this on a Kindle, you are going to have to jailbreak it. I recommend following [this guide](https://www.mobileread.com/forums/showthread.php?t=320564) to jailbreak your Kindle.

- If you clone this project, you should be able to put the directory, `askkobold.koplugin`, in the `koreader/plugins` directory and it should work. If you want to use the plugin without cloning the project, you can download the zip file from the releases page and extract the `askkobold.koplugin` directory to the `koreader/plugins` directory.

- Install [KoboldCpp](https://github.com/LostRuins/koboldcpp).

- Download a GGUF model from Huggingface, for example https://huggingface.co/bartowski/SFR-Iterative-DPO-LLaMA-3-8B-R-GGUF

- Run KoboldCpp and load the GGUF model. See their [wiki](https://github.com/LostRuins/koboldcpp/wiki) for reference.  

- Edit the file `gpt_query.lua` with your favorite text editor, and edit the following line:

  `local api_url = "http://localhost:5001/api/v1/generate"`

  replacing "localhost" with the IP address of the computer where KoboldCpp is running. You might have to configure your computer's firewall to allow your e-reader connect to your computer.

## How To Use

To use AskKobold, simply highlight the text that you want to ask a question about, and select "Ask Kobold" from the menu. The plugin will then send your highlighted text to the KoboldCpp API, and display the answer to your question in a pop-up window.

I hope you enjoy using this plugin and that it enhances your e-reading experience. If you have any feedback or suggestions, please let me know!

License: GPLv3
