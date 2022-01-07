class Location {
  final String img;
  final String title;
  final String add;
  final String dist;

  Location({this.img, this.title, this.add, this.dist});
}

class LocationModel{
  static final location = [
    Location(
      img :"assets/images/home/person1.png",
      title: 'Shopper Stop',
      add: 'Silicon Shoppers, F4, 1st Floor, ...',
      dist: "3.6 Km"
    ),
    Location(
        img :"assets/images/home/person2.png",
        title: 'Be Shopper Stop',
        add: 'Silicon Shoppers, F4, 1st Floor, ...',
        dist: "4.2 Km"
    ),
    Location(
        img :"assets/images/home/person3.png",
        title: 'Be Shopper Stop',
        add: 'Silicon Shoppers, F4, 1st Floor, ...',
        dist: "4.2 Km"
    )
  ];
}

class Location1 {
  final String title;
  final String add;
  final String dist;

  Location1({this.title, this.add, this.dist});
}

class LocationModel1{
  static final location1 = [
    Location1(
      title: 'Chandanvan society',
      add: 'Silicon Shoppers, F4, 1st Floor, Udhna Main Road, udhna, Surat, Gujarat - 394210 (India)',
        // dist: "3.6 Km"
    ),
    Location1(
      title: 'Udhna',
      add: 'Silicon Shoppers, F4, 1st Floor, Udhna Main Road, udhna, Surat, Gujarat - 394210 (India)',
        // dist: "4.2 Km"
    ),
    Location1(
      title: 'Udhna',
      add: 'Udhna, Surat, Gujarat',
        // dist: "4.2 Km"
    ),
    Location1(
      title: 'Udhna Railway Station',
      add: 'Silicon Shoppers, F4, 1st Floor, Udhna Main Road, udhna, Surat, Gujarat - 394210 (India)',
        // dist: "4.2 Km"
    ),
  ];
}