import 'package:auctions/configs/resources/app_ressources.dart';
import 'package:auctions/views/widgets/auction_title.dart';
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: AuctionTitle(
                title: "A propos", color: AppResources.colors.secondary),
          ),
          SizedBox(height: AppResources.sizes.size032),
          const Text(
              '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Bibendum at varius vel pharetra vel. Dui ut ornare lectus sit. Nam libero justo laoreet sit amet cursus. Libero enim sed faucibus turpis in. Adipiscing elit duis tristique sollicitudin nibh sit amet commodo nulla. Consequat interdum varius sit amet mattis vulputate enim nulla aliquet. Tempor orci dapibus ultrices in. Blandit massa enim nec dui nunc mattis enim ut. Et sollicitudin ac orci phasellus egestas. Ultricies mi quis hendrerit dolor magna eget est. Malesuada proin libero nunc consequat. A diam sollicitudin tempor id eu nisl nunc mi ipsum. Faucibus et molestie ac feugiat sed. Est ultricies integer quis auctor elit sed vulputate mi.
      
      Sapien pellentesque habitant morbi tristique senectus et netus. Ac tortor dignissim convallis aenean. Mattis ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Amet purus gravida quis blandit turpis cursus in. Commodo nulla facilisi nullam vehicula ipsum. Cursus sit amet dictum sit amet. Facilisis mauris sit amet massa vitae tortor. Leo vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Purus gravida quis blandit turpis cursus in. Auctor neque vitae tempus quam pellentesque nec nam aliquam. Vitae congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque. Nec ultrices dui sapien eget. Risus commodo viverra maecenas accumsan lacus vel facilisis volutpat. Netus et malesuada fames ac. Auctor elit sed vulputate mi sit amet mauris commodo.
      
      Aliquam nulla facilisi cras fermentum odio eu feugiat pretium. Dignissim convallis aenean et tortor. Ornare lectus sit amet est. Varius quam quisque id diam. Eu facilisis sed odio morbi quis commodo odio aenean. Urna nunc id cursus metus aliquam eleifend mi in nulla. Lobortis elementum nibh tellus molestie nunc non blandit. Posuere urna nec tincidunt praesent semper feugiat nibh. Dui accumsan sit amet nulla facilisi morbi. Neque viverra justo nec ultrices. Magna fermentum iaculis eu non. Id volutpat lacus laoreet non curabitur. Ultrices dui sapien eget mi proin sed libero enim. Sagittis vitae et leo duis ut diam quam nulla. Cursus euismod quis viverra nibh cras. Sem fringilla ut morbi tincidunt augue interdum velit euismod. Tellus mauris a diam maecenas.
      
      Dignissim suspendisse in est ante in nibh mauris cursus mattis. Integer malesuada nunc vel risus commodo viverra maecenas accumsan. Mi tempus imperdiet nulla malesuada. Pellentesque habitant morbi tristique senectus et netus. Felis donec et odio pellentesque diam volutpat commodo sed. Sit amet nulla facilisi morbi tempus iaculis urna id volutpat. Congue nisi vitae suscipit tellus mauris. Leo vel orci porta non pulvinar neque laoreet suspendisse. Bibendum arcu vitae elementum curabitur. Non consectetur a erat nam. Amet massa vitae tortor condimentum lacinia quis. Ut lectus arcu bibendum at varius vel. Pulvinar etiam non quam lacus. Sit amet venenatis urna cursus. Purus ut faucibus pulvinar elementum.
      
      Integer vitae justo eget magna fermentum iaculis. Euismod in pellentesque massa placerat duis. Ullamcorper morbi tincidunt ornare massa eget. Iaculis nunc sed augue lacus viverra. Rhoncus est pellentesque elit ullamcorper dignissim cras. Nunc sed blandit libero volutpat sed cras ornare arcu dui. Tincidunt dui ut ornare lectus. Nunc mi ipsum faucibus vitae aliquet nec. Sed vulputate mi sit amet mauris commodo quis. Nunc sed id semper risus in hendrerit gravida rutrum. Eget nullam non nisi est sit amet.
          '''),
        ],
      ),
    );
  }
}
