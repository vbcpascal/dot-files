# Windows Terminal Settings

1. Download **Windows Terminal** from Microsoft Store and open settings

2. Copy all the codes in *theme.json* and paste it in "schemes"

   ``` json
   "schemes": [
       {
           "name": "Vbcpascal",
           ...
       }
   ] 
   ```

3. Set the "defaults" as

   ``` json
   "defaults": {
               // Put settings here that you want to apply to all profiles.
               "fontFace": "JetBrains Mono",
               "colorScheme": "Vbcpascal" // Default: "Campbell"
           },
   ```
   
   