# DynamicComponentView #
## Create your custom views faster with Interface Builder ##

    @IBDesignable provides functionality for live rendering of changes
    of our custom views directly in a Storyboard or .xib. All we have to do
    is mark the class of a custom view with a @IBDesignable attribute and
    implement the prepareForInterfaceBuilder() method.
    
    @IBInspectable allows us to create attributes in code that we can
    assign in a storyboard or a .xib file. For example, when we want a
    cornerRadius property available in a Storyboard, we create a cornerRadius
    property inside our custom view and mark it with @IBInspectable.

## Preview ##

![ezgif com-video-to-gif](https://user-images.githubusercontent.com/27929436/87292152-ab219c80-c500-11ea-9ac1-1ff33e6de5ee.gif)
