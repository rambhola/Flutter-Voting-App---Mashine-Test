import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import '../model/idea_model.dart';

class IdeaController extends GetxController {
  late Box<IdeaModel> ideaBox;

  final RxList<IdeaModel> ideas = <IdeaModel>[].obs;
  final RxSet<String> votedIdeas = <String>{}.obs;

  final RxString searchText = ''.obs;
  final RxBool sortByVotes = false.obs;
  final RxBool sortByRating = true.obs;

  @override
  void onInit() {
    super.onInit();

    // GET ALREADY OPENED BOX
    ideaBox = Hive.box<IdeaModel>('ideasBox');

    loadIdeas();

    //AUTO LISTEN
    ideaBox.listenable().addListener(() {
      loadIdeas();
    });
  }

  void loadIdeas() {
    ideas.assignAll(ideaBox.values.toList());
  }

  Future<void> addIdea(IdeaModel idea) async {
    await ideaBox.add(idea);
  }

  //Hive DB Permanently delete
  Future<void> deleteIdea(IdeaModel idea)async {
    await idea.delete();
  }

  Future<void> toggleFavorite(IdeaModel idea) async {
    idea.isFavorite = !idea.isFavorite;
    await idea.save();

  }



  Future<void> upvoteIdea(IdeaModel idea) async {
    if (votedIdeas.contains(idea.key.toString())) {
      Get.snackbar("Already Voted", "You can vote only once");
      return;
    }

    idea.votes++;
    await idea.save();

    votedIdeas.add(idea.key.toString());
  }

  Future<void> clearIdeas() async {
    await ideaBox.clear();
    ideas.clear();
    votedIdeas.clear();
  }
}
