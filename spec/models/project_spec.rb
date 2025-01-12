require 'rails_helper'


RSpec.describe Project, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :material}
  end

  describe "relationships" do
    it {should belong_to :challenge}
    it {should have_many :contestant_projects}
    it {should have_many(:contestants).through(:contestant_projects)}
  end

  before :each do
    @contestant_1 = create(:contestant)
    @contestant_2 = create(:contestant)
    @contestant_3 = create(:contestant)
    @challenge_1  = create(:challenge)
    @project_1    = create(:project, challenge: @challenge_1)
    @project_2    = create(:project, challenge: @challenge_1)
    @project_3    = create(:project, challenge: @challenge_1)
    @contestant_1.projects << @project_1
    @contestant_1.projects << @project_2
    @contestant_2.projects << @project_1
    @contestant_2.projects << @project_3
    @contestant_3.projects << @project_1
  end

  describe '.contestant_count' do
    it 'counts the number of contestants assoctiated with the project' do

      expect(@project_1.contestant_count).to eq(3)
      expect(@project_2.contestant_count).to eq(1)
      expect(@project_3.contestant_count).to eq(1)
    end
  end

  describe '.average years experience' do
    it 'average the contestants  with the project' do

      expect(@project_1.average_years_experience).to eq(@project_1.contestants.average(:years_of_experience).to_f.round(2))
      expect(@project_2.average_years_experience).to eq(@project_2.contestants.average(:years_of_experience).to_f.round(2))
      expect(@project_3.average_years_experience).to eq(@project_3.contestants.average(:years_of_experience).to_f.round(2))
    end
  end
end
