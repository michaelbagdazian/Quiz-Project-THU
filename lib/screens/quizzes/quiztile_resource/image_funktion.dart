
image(String category){
  String image  = category;
  switch(image) {
    case "Test":
      return 'assets/images/education.jpg';
    case "History":
      return 'assets/images/tile_baground/history.jpg';
    case "Phyiscs":
      return 'assets/images/tile_baground/science.jpg';
    case "CS":
      return 'assets/images/tile_baground/computer_science.jpg';
    case "Games":
      return 'assets/images/tile_baground/video_games.jpg';
    case "Sport":
      return 'assets/images/science.jpg';
    case "Math":
      return 'assets/images/science.jpg';
    case "Music":
      return 'assets/images/tile_baground/music.jpg';
    default:
      return 'assets/images/hexagonal_background.jpg';

  }
}