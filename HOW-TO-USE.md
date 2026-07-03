## HOW TO USE THIS MODULE. THIS IS IMPORTANT!!

This is an easy and simple guide to teach you how to use this lightweight module of mine.

new()
Creates a new instance with the table of given properties
  param Object Name = string: The name of the Instance (Class Name, not to be confused with property 'Name') that you are creating.
  param Object Properties (Optional) = table: The given Object's properties that have an Index of the property's name and a Value of what you want to set the property to. (Optional due to minor cases where you may not want to or need to have properties for an Instance.)
  param Style (Optional) = string: The "Style" you would like to give the object. It is extremely similar to the Properties table, but overrides it. Mainly to make it easier to make UI that have similar looks or general themes. Do NOT put a table for this, as it will be invalid. Instead use a string that's the same as a name for a Style you created using the "newStyle()" function.
  param Behavior (Optional) = function( Instance ): This is mainly to account for those who put OOP first. Though it may be a bit difficult to understand, it is easy to use and quite useful. The main purpose is to make it possible to have replicated behavior for different instances without having to make way more functions in things like modules or local scripts in the memory than needed to support script behavior.
    all you need to do to make it work properly is make ONE parameter in the function that will be given as the Object created through this function itself and run the code through there as if it was its own script.

  EXAMPLE:
    instances.new( 'TextButton', { Name = 'TESTBUTTON', Parent = game:GetService('Players').LocalPlayer.PlayerGui.MainGUI, Text = 'Press me!' }, 'Round', function( Button ) Button.Activated:Connect(function() print('Hello World!') end) end ) -- Creates a new button with a 'Round' Style that, on clicked will print 'Hello World!'
     Note that Style being set to 'Round' is ONLY to show exactly HOW to use the parameter, it should not be used as a real value unless the case is that you have already created and registered a "Style" with that Name.

newStyle()
Registers a new 'Style' within a table inside of the module that cannot be tampered with directly, which can be used to make a Theme for things like UI, SFX, and more! This is similar to how CSS works, just a bit different!
  param Style Name = string: The name of the Style. Can be anything! It's just important you remember this so you can actually use it later on! ^^
  param Style Properties = table: The Style's Properties. This is similar to the 'Object Properties' parameter in the new() function, but will override those properties when this Style's name is set as the 'Style' parameter in the function

  EXAMPLE:
    instances.newStyle( 'Button', { BackgroundColor3 = Color3.new( .5, 0, .5 ), BackgroundTransparency = .5 } )
    instances.new( 'ImageButton', { Name = 'STYLESEXAMPLE', Parent = game:GetService('Players').LocalPlayer.PlayerGui.MainGUI, Image = 'rbxassetid://1234567890' }, 'Button' )
     This shows a better example of how exactly to use the Styles feature and how it can save quite a bit of time when making certain UI.

instantiate()
Arguably the most Complex, but important and useful part of this whole module
This function will create a New Instance similar to new, but using a table full of important Properties so you can make full Layouts and such without having to call the new function multiple times! For a better way to understand how to use this, please see the Example or read the parameters!

  The Instantiate Data is technically a whole new Type on it's own (Referred to here as 'InstantiateData' as seen in the script itself), so it should probably be documented on it's values and how they work:
  {

    Class: string = The Class Name of the Object being Created, basically the same as what's shown as the first parameter in the new function.
    Properties: table (Optional) = The Properties of the Object being Created, just like the Value above, it functions basically the same as it's counterpart in the new function, that being the second parameter.
    Style: string (Optional) = The Style of the Object being Created, just like the Values above, it functions basically the same as it's counterpart in the new function, that being the third parameter, I wouldn't recommend this in the root of the hierarchy if there's no need to have it here as it just wastes time unless the Frame or whatever's in it is not fully Transparent.
    Children: table (Optional, but if you don't use this one, then I recommend just using the new function for this operation.) = A table containing the object's children that's basically a table exactly like the Instantiate Data that can be recursively nested infinitely, and is the main reason to use this, please DO NOT use non-integer indexes for this one, because it relies on them or else it won't work.
    Behavior: (Optional) = function( Instance ): The Behavior of the Object being Created, just like the Values before the One Above, it functions basically the same as it's counterpart in the new function, that being the fourth parameter.
  
  }
  
  param Instantiate Data = InstantiateData: The main properties of the Object/Group

  EXAMPLE:
    instances.instantiate( {

      -- It's recommended to store most of these values in a sliced, multi-line variable if it's to be reused as a type of raw template, or you can just keep it in the function. Either way this is mainly for readability.
      Class = 'Frame',
      Properties = {
        Name = 'TESTFRAME',
        Parent = game:GetService('Players').LocalPlayer.PlayerGui.MainGUI,
        Size = UDim2.fromScale( .1, 1 )
      },
      Children = {
        {
          Class = 'ImageButton',
          Properties = {
            BackgroundColor3 = Color3.new( 1 ),
            Name = 'Button1'
          }
        },
        {
          Class = 'ImageButton',
          Properties = {
            BackgroundColor3 = Color3.new( 0, 1 ),
            Name = 'Button2',
            Position = UDim2.fromOffset( 0, 100 )
          }
        },
        {
          Class = 'ImageButton',
          Properties = {
            BackgroundColor3 = Color3.new( 0, 0, 1 ),
            Name = 'Button3',
            Position = UDim2.fromOffset( 0, 200 )
          }
        }
      }
      
    } )

Well that's about all I've got for now, folks. If you have any suggestions that I might add on to this later, please let me know, and tell me if you run into any bugs while using this, and I'll fix it as soon as I can. Have fun! ^^
