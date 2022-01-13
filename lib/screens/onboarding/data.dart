class SliderModel {
  String imagePath;
  String title;
  String description;
  SliderModel({this.imagePath, this.title, this.description});

  void setImgPath(String getImagePath) {
    imagePath = getImagePath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDescription(String getDescription) {
    description = getDescription;
  }

  String getImagePath() {
    return imagePath;
  }

  String getTitle() {
    return title;
  }

  String getDescription() {
    return description;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();
  //1st screen
  sliderModel.setImgPath("assets/onboard/01onboard.png");
  sliderModel.setTitle("Missing Taking Pills ?");
  sliderModel.setDescription(
      "Now onwards using pill reminder you won't forget to take pills");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  //2nd screen
  sliderModel.setImgPath("assets/onboard/02onboard.png");
  sliderModel.setTitle("Health Improvement");
  sliderModel.setDescription(
      "With regular taking pills you will recover soon and safe from side-effects from not taking pills regularly.");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  //3rd  screen
  sliderModel.setImgPath("assets/onboard/03onboard.png");
  sliderModel.setTitle("Get Notification's");
  sliderModel.setDescription(
      "Get notified for every pill , that too with catchy sound");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  return slides;
}
