require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(video.title)
    expect(page).to have_content(tutorial.title)
  end

  it 'vistor sees tutorial title from the home page unless its hidden' do
    user = create(:user)

    tutorial_1 = create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial_1.id)

    tutorial_2 = create(:tutorial, classroom: true)
    video_2 = create(:video, tutorial_id: tutorial_2.id)


    visit '/'

    expect(page).to have_content(tutorial_1.title)
    expect(page).to_not have_content(tutorial_2.title)

    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"

    visit '/'

    expect(page).to have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)
  end

  it 'vistor clicks on a tutorial title from the home page unless its hidden' do
    user = create(:user)

    tutorial_1 = create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial_1.id)

    tutorial_2 = create(:tutorial, classroom: true)
    video_2 = create(:video, tutorial_id: tutorial_2.id)

    visit "tutorials/#{tutorial_2.id}"

    expect(page).to have_content("Video is restricted to registered users only")

    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"

    visit "tutorials/#{tutorial_2.id}"

    expect(page).to have_content(tutorial_2.title)
  end
end
