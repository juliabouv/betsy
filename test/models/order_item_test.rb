require "test_helper"

describe OrderItem do
  let (:order_items1) {
    order_items(:order_items1)
  }

  let (:order1) {
    orders(:order1)
  }

  let (:product1) {
    products(:product1)
  }
  
  it "can be instantiated" do
    expect(order_items1.valid?).must_equal true
  end
  
  it "will have the required fields" do
    expect(order_items1.quantity).wont_be_nil
    expect(order_items1.product).wont_be_nil
    expect(order_items1.order).wont_be_nil
    expect(order_items1.shipped).wont_be_nil
    
    [:quantity, :product, :order, :shipped].each do |attribute|
      expect(order_items1).must_respond_to attribute
    end
  end
  
  describe "relationships" do
    it "belongs to product" do
      expect(order_items1.product).must_be_instance_of Product
      expect(order_items1.product).wont_be_nil
    end

    it "belongs to order" do
      expect(order_items1.order).must_be_instance_of Order
      expect(order_items1.order).wont_be_nil
    end
  end

  describe "validations" do
    it "must have a product_id" do
      no_product_id = OrderItem.create(quantity: 1, shipped: false, product: nil, order: order1)

      expect(no_product_id.valid?).must_equal false
      expect(no_product_id.errors.messages).must_include :product
      expect(no_product_id.errors.messages[:product]).must_equal ["must exist"]
    end

    it "must have a order_id" do
      no_order_id = OrderItem.create(quantity: 1, shipped: false, product: product1, order: nil)

      expect(no_order_id.valid?).must_equal false
      expect(no_order_id.errors.messages).must_include :order
      expect(no_order_id.errors.messages[:order]).must_equal ["must exist"]
    end

    it "quantity must be numeric" do
      invalid_quantity = OrderItem.create(quantity: 'nope', shipped: false, product: product1, order: order1)

      expect(invalid_quantity.valid?).must_equal false
      expect(invalid_quantity.errors.messages).must_include :quantity
      expect(invalid_quantity.errors.messages[:quantity]).must_equal ["is not a number"]
    end

    it "is invalid if quantity is not present" do
      is_invalid = order_items(:order_items1)
      is_invalid.quantity = nil

      refute(is_invalid.valid?)
      expect(is_invalid.errors.messages).must_include :quantity
      expect(is_invalid.errors.messages[:quantity]).must_equal ["can't be blank", "is not a number"]
    end


    it "is invalid if quantity is not greater than zero" do
      is_invalid = order_items(:order_items1)
      is_invalid.quantity = 0

      refute(is_invalid.valid?)
      expect(is_invalid.errors.messages).must_include :quantity
      expect(is_invalid.errors.messages[:quantity]).must_equal ["must be greater than 0"]

    end
  end

  describe "Custom methods" do
    describe "subtotal" do
      it "accurately calculates the total" do
        expect(order_items1.subtotal.amount).must_equal 3000 * 10**-2
      end

      it "the total is 0 if there are no items" do
        order_items1.quantity = 0

        expect(order_items1.subtotal).must_equal 0
      end
    end

    describe "updated stock" do
      it "accurately calculates the updated_stock amount" do
        expect(order_items1.updated_stock).must_equal 8
      end
    end
  end
end
