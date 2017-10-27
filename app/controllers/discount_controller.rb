class DiscountController < UIViewController
	def viewDidLoad
		super
		self.view.backgroundColor = UIColor.colorWithRed(0.9400, green:0.9400, blue:0.9400, alpha: 1)

		@container = UIView.alloc.initWithFrame([[0, 0], [self.view.frame.size.width, 90]])
		@container.backgroundColor = UIColor.colorWithRed(0.90, green:0.90, blue:0.90, alpha: 1)
		self.view.addSubview(@container)

		@view = UIView.alloc.initWithFrame([[0, 90], [self.view.frame.size.width, self.view.frame.size.height]])
		self.view.addSubview(@view)

	  #METHODS
	  	screenViews
	  	form
	  	textDelegates
	  	@segment.selectedSegmentIndex = 0
	  	@segment2.selectedSegmentIndex = 0

	  #TOP BAR FOR KEYBOARD
		@toolBar = UIToolbar.alloc.initWithFrame(CGRectMake(0, 0, 320, 50))
		@toolBar.barStyle = UIBarStyleBlackTranslucent
		@toolBar.sizeToFit

		toolItems = NSMutableArray.alloc.init
		@cancel = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemCancel, target: self, action: "cancelPad")
		@flexible = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemFlexibleSpace, target: nil, action: nil)
		@previous = UIBarButtonItem.alloc.initWithTitle("Previous", style: UIBarButtonItemStyleBordered, target: self, action: "previousField")
		@next = UIBarButtonItem.alloc.initWithTitle("Next", style: UIBarButtonItemStyleBordered, target: self, action: "nextField")

		toolItems = [@cancel, @flexible, @previous, @next]
		@toolBar.setItems(toolItems, animated: true)

	end

	def screenViews
		if UIScreen.mainScreen.bounds.size.height == 480
			@view = UIScrollView.new
	        @view.frame = [[0,90], [self.view.frame.size.width, self.view.frame.size.height]]
	        @view.contentSize = [self.view.frame.size.width, self.view.frame.size.height + 100]
	        @view.delegate = self
	        self.view.addSubview(@view)
	    else
	    	@view = UIView.alloc.initWithFrame([[0, 90], [self.view.frame.size.width, self.view.frame.size.height]])
			self.view.addSubview(@view)
		end
	end

	def form
		@total = UILabel.new
		@total.frame = [[0, 30], [@container.frame.size.width - 27, 60]]
		@total.text = "$0.00"
		@total.textAlignment = NSTextAlignmentRight
		@total.font = UIFont.fontWithName("Heiti TC", size: 45)
		@container.addSubview(@total)
		
		@price = UITextField.new
		@price.frame = [[0,0], [@view.frame.size.width, 50]]
		@price.keyboardType = UIKeyboardTypeDecimalPad
		@price.font = UIFont.fontWithName("Heiti TC", size: 30)
		@price.placeholder = "$ ticket price"
		@price.textAlignment = NSTextAlignmentRight
		@view.addSubview(@price)
		@price.clearButtonMode = UITextFieldViewModeAlways
		@price.rightViewMode = UITextFieldViewModeAlways
		@price.rightView = nil

	  #Segment
		@array = NSArray.arrayWithObjects("%", "$", nil)
		@segment = UISegmentedControl.alloc.initWithItems(@array)
		@segment.frame = [[0, 0], [80,40]]
		@segment.segmentedControlStyle = UISegmentedControlStyleBordered
		@segment.tintColor = UIColor.clearColor
			font = { UITextAttributeFont => UIFont.fontWithName("Heiti TC", size:18), 
					 UITextAttributeTextColor => UIColor.colorWithWhite(0.70,alpha:1) }
			@segment.setTitleTextAttributes(font, forState:UIControlStateNormal)
			font = { UITextAttributeFont => UIFont.fontWithName("Heiti TC", size:26), 
					 UITextAttributeTextColor => UIColor.colorWithRed(0.2977, green:0.8353, blue:0.549, alpha: 1) }
			@segment.setTitleTextAttributes(font, forState:UIControlStateSelected)
		@segment.addTarget(self, action: "calculate", forControlEvents:UIControlEventValueChanged)
		@view.addSubview(@segment)

		@discount = UITextField.new
		@discount.frame = [[@discount.frame.origin.x + 5, @price.frame.origin.y + 50],
						   [@view.frame.size.width - 5, 50]]
		@discount.keyboardType = UIKeyboardTypeDecimalPad
		@discount.font = UIFont.fontWithName("Heiti TC", size: 30)
		@discount.placeholder = "discount"
		@discount.textAlignment = NSTextAlignmentRight
		@view.addSubview(@discount)
		@discount.leftViewMode = UITextFieldViewModeAlways
		@discount.leftView = @segment
		@discount.clearButtonMode = UITextFieldViewModeAlways

	  #Segment
		@array2 = NSArray.arrayWithObjects("%", "$", nil)
		@segment2 = UISegmentedControl.alloc.initWithItems(@array2)
		@segment2.frame = [[0, 0], [80,40]]
		@segment2.segmentedControlStyle = UISegmentedControlStyleBordered
		@segment2.tintColor = UIColor.clearColor
			font = { UITextAttributeFont => UIFont.fontWithName("Heiti TC", size:18), 
					 UITextAttributeTextColor => UIColor.colorWithWhite(0.70,alpha:1) }
			@segment2.setTitleTextAttributes(font, forState:UIControlStateNormal)
			font = { UITextAttributeFont => UIFont.fontWithName("Heiti TC", size:26), 
					 UITextAttributeTextColor => UIColor.colorWithRed(0.2977, green:0.8353, blue:0.549, alpha: 1) }
			@segment2.setTitleTextAttributes(font, forState:UIControlStateSelected)
		@segment2.addTarget(self, action: "calculate", forControlEvents:UIControlEventValueChanged)
		@view.addSubview(@segment2)

		@add_discount = UITextField.new
		@add_discount.frame = [[@add_discount.frame.origin.x + 5, @discount.frame.origin.y + 50], 
							   [@view.frame.size.width - 5, 50]]
		@add_discount.keyboardType = UIKeyboardTypeDecimalPad
		@add_discount.font = UIFont.fontWithName("Heiti TC", size: 30)
		@add_discount.placeholder = "add'l discount"
		@add_discount.textAlignment = NSTextAlignmentRight
		@view.addSubview(@add_discount)
		@add_discount.leftViewMode = UITextFieldViewModeAlways
		@add_discount.leftView = @segment2
		@add_discount.clearButtonMode = UITextFieldViewModeAlways

		@tax = UITextField.new
		@tax.frame = [[@tax.frame.origin.x, @add_discount.frame.origin.y + 50],
					  [@view.frame.size.width, 50]]
		@tax.keyboardType = UIKeyboardTypeDecimalPad
		@tax.font = UIFont.fontWithName("Heiti TC", size: 30)
		@tax.placeholder = "tax %"
		@tax.textAlignment = NSTextAlignmentRight
		@view.addSubview(@tax)
		@tax.clearButtonMode = UITextFieldViewModeAlways

	  #Clear Button
        @clear = UIButton.buttonWithType(UIButtonTypeRoundedRect)
		@clear.setTitle("c", forState: UIControlStateNormal)
		@clear.setTitleColor(UIColor.colorWithRed(0.90, green:0.90, blue:0.90, alpha: 1), forState: UIControlStateNormal)
		@clear.backgroundColor = UIColor.colorWithRed(0.9059, green:0.298, blue:0.2353, alpha: 1)
		@clear.frame = [[0,@tax.frame.origin.y + 65],[65, 55]]
		@clear.font = UIFont.fontWithName("Heiti TC", size: 28)
		@view.addSubview(@clear)
		@clear.addTarget(self, action: "clearAll", forControlEvents:UIControlEventTouchUpInside)

	  #Submit Button
        @submit = UIButton.buttonWithType(UIButtonTypeRoundedRect)
		@submit.setTitle("discount", forState: UIControlStateNormal)
		@submit.setTitleColor(UIColor.colorWithRed(0.90, green:0.90, blue:0.90, alpha: 1), forState: UIControlStateNormal)
		@submit.backgroundColor = UIColor.colorWithRed(0.1176, green:0.1176, blue:0.1255, alpha: 1)
		@submit.frame = [[@submit.frame.origin.x + @clear.frame.size.width,@tax.frame.origin.y + 65],
						[@view.frame.size.width - @clear.frame.size.width, 55]]
		@submit.font = UIFont.fontWithName("Heiti TC", size: 28)
		@view.addSubview(@submit)
		@submit.addTarget(self, action: "calculate", forControlEvents:UIControlEventTouchUpInside)
	end

	def textDelegates
		if UIScreen.mainScreen.bounds.size.height > 480
			@price.delegate = self
			@tax.delegate = self
			@discount.delegate = self
			@add_discount.delegate = self
		else
			false
		end
	end

	def textFieldDidBeginEditing(textField)
		if UIScreen.mainScreen.bounds.size.height > 568
			if textField == @price
				@price.inputAccessoryView = @toolBar
				@next.enabled = true
				@previous.enabled = nil
			elsif textField == @discount
				@discount.text = nil
				@discount.inputAccessoryView = @toolBar
				@previous.enabled = true
				@next.enabled = true
			elsif textField == @add_discount
				@add_discount.text = nil
				@add_discount.inputAccessoryView = @toolBar
				@next.enabled = true
				@previous.enabled = true
			elsif textField == @tax
				@tax.text = nil
				@tax.inputAccessoryView = @toolBar
				@previous.enabled = true
				@next.enabled = nil
			else
				false
			end
		else
			false
		end
	end

	def textFieldDidEndEditing(textField)
		if textField == @price
			formatPrice
		elsif textField == @discount
			formatDiscount				
		elsif textField == @add_discount
			formatDiscount2
		elsif textField == @tax
			formatTax
		else
			false
		end
	end

	def calculate
		@z = 0
	  #Format add_discount
	  	formatPrice
		formatDiscount
		formatDiscount2
		formatTax
	  #Textfields
	  	price = @price.text.delete('$,').to_f
		tax = @tax.text.to_f
		discount = @discount.text.delete('$,').to_f
		additional = @add_discount.text.delete('$,').to_f
	  	if @segment.selectedSegmentIndex == 0 && @segment2.selectedSegmentIndex == 0
	  		new_total = price - (price * (discount.to_f/100))
	  		y = new_total - (new_total * (additional.to_f/100))
	  	elsif @segment.selectedSegmentIndex == 1 && @segment2.selectedSegmentIndex == 0
	  		new_total = price - discount
	  		y = new_total - (new_total * (additional.to_f/100))
	  	elsif @segment.selectedSegmentIndex == 0 && @segment2.selectedSegmentIndex == 1
	  		new_total = price - (price * (discount.to_f/100))
	  		y = new_total - additional
	  	elsif @segment.selectedSegmentIndex == 1 && @segment2.selectedSegmentIndex == 1
	  		new_total = price - discount
	  		y = new_total - additional
	  	else
	  		false
	  	end
			@z = y + (y * (tax.to_f/100))
			x = comma_number('%.02f' % @z)

		@views = @container.subviews	
		if	@views.count >= 1
			@views.last.removeFromSuperview
			@new_label = UILabel.new
			@new_label.frame = [[0, 30], [@container.frame.size.width - 27, 60]]
			if @z >= 0
				@new_label.text = "$#{x}"
			elsif @z == "Error"
				@new_label.text = "$0.00"
			else
				@new_label.text = "Error"
				alert2
			end
			@new_label.textAlignment = NSTextAlignmentRight
			@new_label.font = UIFont.fontWithName("Heiti TC", size: 45)
			@container.addSubview(@new_label)
		else
			false
		end	
	end

	def comma_number(number)
		whole, decimal = number.to_s.split(".")
  		whole_with_commas = whole.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
  		[whole_with_commas, decimal].compact.join(".")
	end

	def formatPrice
		float = @price.text.delete('$,').to_f
		new_price = comma_number('%.02f' % float)
		if float > 0
			@price.text = "$#{new_price}"
		else
			@price.text = nil
		end
	end

	def formatDiscount
		discount = @discount.text.delete('$,%').to_f
		if @segment.selectedSegmentIndex == 0
			if discount > 0
				@discount.text = "#{'%.02f' % discount}%"
			else 
				@discount.text = nil
			end
		else @segment.selectedSegmentIndex == 1
			if discount > 0
				add_price = comma_number('%.02f' % discount)
				@discount.text = "$#{add_price}"
			else
				@discount.text = nil
			end
		end
	end

	def formatDiscount2
		additional = @add_discount.text.delete('$,%').to_f
		if @segment2.selectedSegmentIndex == 0
			if additional > 0
				@add_discount.text = "#{'%.02f' % additional}%"
			else 
				@add_discount.text = nil
			end
		else @segment2.selectedSegmentIndex == 1
			if additional > 0
				add_price = comma_number('%.02f' % additional)
				@add_discount.text = "$#{add_price}"
			else
				@add_discount.text = nil
			end
		end
	end

	def formatTax
		tax = @tax.text.delete('%').to_f
		if tax > 0
			@tax.text = "#{'%.02f' % tax}%"
		else 
			@tax.text = nil
		end
	end

	def alert2
		@error = UIAlertView.alloc.initWithTitle("Oops",
		message: "It looks like your discount was calculated incorrectly.  Please check each field to be sure you entered in correct amounts",
		delegate: self, cancelButtonTitle: "Okay", 
		otherButtonTitles: nil)
		@error.delegate = self
		@error.show
	end

	def alertView(alertView, clickedButtonAtIndex: buttonIndex)
		if buttonIndex == 0
		else
			false
		end
	end
	
  	def cancelPad
  		if @price == firstResponder
  			@price.resignFirstResponder
  		elsif @discount == firstResponder
  			@discount.resignFirstResponder
		elsif @add_discount == firstResponder
  			@add_discount.resignFirstResponder
  		elsif @tax == firstResponder
  			@tax.resignFirstResponder
  		else
  			false
  		end
  	end

  	def nextField
  		if @price == firstResponder
  			@discount.becomeFirstResponder
  		elsif @discount == firstResponder
  			@add_discount.becomeFirstResponder
  		elsif @add_discount == firstResponder
  			@tax.becomeFirstResponder
  		else
  			false
  		end
  	end

  	def previousField
  		if @discount == firstResponder
  			@price.becomeFirstResponder
  		elsif @add_discount == firstResponder
  			@discount.becomeFirstResponder
  		elsif @tax == firstResponder
  			@add_discount.becomeFirstResponder
  		else
  			false
  		end
  	end

  	def clearAll
  		@price.text = nil
  		@discount.text = nil
  		@add_discount.text = nil
  		@tax.text = nil
  		@price.becomeFirstResponder
  		calculate
  	end
end