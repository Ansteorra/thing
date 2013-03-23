require 'spec_helper'

describe CalendarsController, focus: true do
  def create_instructables
    @user1 = create(:instructor)
    @user2 = create(:instructor)
    @instructable1 = create(:scheduled_instructable, user_id: @user1.id)
    @instructable2 = create(:scheduled_instructable, user_id: @user2.id)

    @instructable1.update_column(:scheduled, true)
    @instructable2.update_column(:scheduled, true)
  end

  describe "PDF" do
    describe "without classes" do
      it "renders full" do
        visit calendars_path(format: :pdf)
        page.response_headers['Content-Type'].should == 'application/pdf'
        page.body.should_not be_blank
        page.body[0..3].should == '%PDF'
      end

      it "renders brief" do
        visit calendars_path(format: :pdf, brief: true)
        page.response_headers['Content-Type'].should == 'application/pdf'
        page.body.should_not be_blank
        page.body[0..3].should == '%PDF'
      end
    end

    describe "with classes" do
      before :each do
        create_instructables
      end

      it "renders full" do
        visit calendars_path(format: :pdf)
        page.response_headers['Content-Type'].should == 'application/pdf'
        page.body.should_not be_blank
        page.body[0..3].should == '%PDF'
      end

      it "renders brief" do
        visit calendars_path(format: :pdf, brief: true)
        page.response_headers['Content-Type'].should == 'application/pdf'
        page.body.should_not be_blank
        page.body[0..3].should == '%PDF'
      end
    end
  end
end
