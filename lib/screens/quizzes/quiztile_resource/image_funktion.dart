
image(String category){
  String image  = category;
  switch(image) {
    case "Test":
      return 'assets/images/education.jpg';
    case "History":
      return 'assets/images/history2.jpg';
    case "Phyiscs":
      return 'assets/images/science.jpg';
    case "CS":
      return 'assets/images/computer_science.jpg';
    case "Games":
      return 'assets/images/video_games.jpg';
    case "Sport":
      return 'assets/images/science.jpg';
    case "Math":
      return 'assets/images/science.jpg';
    case "Music":
      return 'assets/images/music.jpg';
    default:
      return 'assets/images/hexagonal_background.jpg';

  }
}