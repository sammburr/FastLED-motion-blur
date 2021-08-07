#tag Window
Begin Window Window1
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   758
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   988316081
   MenuBarVisible  =   True
   MinHeight       =   300
   MinimizeButton  =   False
   MinWidth        =   400
   Placement       =   0
   Resizeable      =   True
   Title           =   "image to 24bitHex"
   Visible         =   True
   Width           =   424
   Begin Label Label1
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   56
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Drop a Picture Here"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   296
   End
   Begin Canvas Canvas1
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   227
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   61
      Transparent     =   True
      Visible         =   True
      Width           =   384
   End
   Begin TextArea TextArea1
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF00
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   438
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   300
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   1
      ValidationMask  =   ""
      Visible         =   True
      Width           =   384
   End
   Begin PushButton PushButton1
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Write to File"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   297
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   36
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   107
   End
   Begin Label pixCount
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   297
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "pixels"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   11
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
End
#tag EndWindow

#tag WindowCode
	#tag MenuHandler
		Function EditPaste() As Boolean Handles EditPaste.Action
			dim cb as new Clipboard
			if cb.PictureAvailable then
			//TextArea1.text = Picture2Base64(cb.Picture)
			self.Title = "Pasted Picture"
			end if
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileOpen() As Boolean Handles FileOpen.Action
			dim od as new OpenDialog
			od.Filter = pictures.Jpeg + pictures.Png
			dim f as FolderItem = od.ShowModal
			if f<>nil then
			dim p as Picture = picture.Open(f)
			ConvertPicture(p)
			self.Title = f.Name
			end if
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub ConvertPicture(p as Picture)
		  dim ms as Double = Microseconds
		  
		  Dim hSize as Integer = p.Width
		  Dim vSize as Integer = p.height
		  Dim halfH as Integer = hSize/2
		  Dim halfV as Integer = vSize/2
		  
		  
		  
		  debugWindow.log("Size " +str(hsize)+","+str(vSize))
		  
		  
		  Dim outP as new Picture(hSize,vSize)
		  
		  Dim surf as RGBSurface = p.RGBSurface
		  Dim outSurf as RGBSurface = outP.RGBSurface
		  
		  for Y as Integer = 0 to vSize-1 step 2
		    for X as Integer = 0 to hSize-1 step 4
		      
		      //TL
		      outsurf.Pixel(x\2, y\2) = Surf.Pixel(x, y) 
		      outsurf.Pixel((x\2)+1, y\2) = Surf.Pixel(x+1, y) 
		      
		      //TR
		      outsurf.Pixel((x\2)+halfH, y\2) = Surf.Pixel(x+2, y) 
		      outsurf.Pixel((x\2)+halfH+1, y\2) = Surf.Pixel(x+3, y) 
		      
		      //BL
		      outsurf.Pixel(x\2, (y\2)+halfV) = Surf.Pixel(x, y+1) 
		      outsurf.Pixel((x\2)+1, (y\2)+halfV) = Surf.Pixel(x+1, y+1) 
		      
		      //BR
		      outsurf.Pixel((x\2)+halfH, (y\2)+halfV) = Surf.Pixel(x+2, y+1) 
		      outsurf.Pixel((x\2)+halfH+1, (y\2)+halfV) = Surf.Pixel(x+3, y+1) 
		      
		      
		    next
		  next
		  
		  outPic= outP
		  
		  Canvas1.Refresh
		  debugWindow.log ("UpDateScreen in (" + Format((Microseconds - ms)/1000,"#0.0") + "ms)")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ConvertToAlphaPicture(input as Picture) As Picture
		  If input.HasAlphaChannel Then Return input
		  
		  debugWindow.log("Has alpha "+str(input.HasAlphaChannel))
		  debugWindow.log("Depth "+input.Depth.ToString)
		  
		  Var result As New Picture(input.Width, input.Height)
		  result.Graphics.DrawPicture(input, 0, 0)
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DropCode(obj as DragItem)
		  //Private Const LayoutEditorIcon = "value"
		  dim p as Picture
		  if obj.PictureAvailable then
		    p = obj.Picture
		    self.Title = "Dropped Picture"
		  elseif obj.FolderItemAvailable then
		    p = picture.Open(obj.FolderItem)
		    self.Title = obj.FolderItem.Name
		  end if
		  
		  
		  mask = p.CopyMask()
		  
		  
		  
		  if p<>nil then
		    
		    generate(p)
		    
		    
		    
		    self.Refresh()
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub generate(p as Picture)
		  Dim ms As Double = Microseconds
		  
		  Dim surf as RGBSurface = p.RGBSurface
		  
		  
		  
		  
		  Dim hSize as Integer = p.Width
		  Dim vSize As Integer = p.height
		  
		  
		  Dim X,Y As Integer = 0
		  
		  TextArea1.Text =""
		  
		  
		  debugWindow.log("Size " +str(hsize)+","+str(vSize))
		  
		  outPic= p
		  
		  Canvas1.Refresh
		  
		  Var count As Integer
		  
		  Var textCol As String
		  
		  textCol=textCol + ("uint32_t image[] = {")
		  
		  For X = 0 To hSize -1
		    
		    
		    For Y = 0 To vSize -1
		      
		      pixelArray.Add(surf.Pixel(X,Y))
		      Var pixelColor As Color = surf.Pixel(X,Y)
		      Var hexColor As String = pixelColor.ToString
		      'hexcolor = hexcolor.Replace("&h00", "0x00") //32bit
		      hexcolor = hexcolor.Replace("&h00", "0x")    //24bit
		      
		      textCol=textCol + (hexColor+",")
		      
		      count = count +1
		      
		    next
		    
		  Next
		  
		  textCol=textCol + "};"
		  
		  textCol = textCol.Replace(",}" , "}")
		  
		  TextArea1.Text = textCol
		  
		  Window1.pixCount.Text = Str(count)
		  
		  //MessageBox("Array size: "+Str(count))
		  
		  debugWindow.Log ("UpDateScreen in (" + Format((Microseconds - ms)/1000,"#0.0") + "ms)")
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveFile()
		  
		  Var title As String = Window1.Title
		  title = title.Replace(".png","")
		  
		  Var f As FolderItem
		  Var stream As BinaryStream
		  f = FolderItem.ShowSaveFileDialog(FileTypes1.ESPbinary, (title+".bin"))
		  
		  If f <> Nil Then
		    stream = BinaryStream.Create(f,True)
		    For i As Integer = pixelArray.LastIndex DownTo 0 
		      Var red As Byte = pixelArray(i).Red
		      Var green As Byte = pixelArray(i).Green
		      Var blue As Byte = pixelArray(i).Blue
		      
		      
		      stream.WriteUInt8(red)
		      stream.WriteUInt8(green)
		      stream.WriteUInt8(blue)
		      
		      
		    Next
		    stream.Close
		  End If
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		outPic As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		pixelArray() As Color
	#tag EndProperty


#tag EndWindowCode

#tag Events Label1
	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
		  DropCode(obj)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  me.AcceptPictureDrop
		  me.AcceptFileDrop(pictures.Jpeg + pictures.Png)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Canvas1
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  if outPic <> nil then
		    
		    
		    g.DrawPicture(outPic,0,0,me.Width,me.Height,0,0,outPic.width,outPic.height)
		    
		  end
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
		  DropCode(obj)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  me.AcceptPictureDrop
		  me.AcceptFileDrop(pictures.Jpeg + pictures.Png)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton1
	#tag Event
		Sub Action()
		  SaveFile()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Position"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Appearance"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="outPic"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
