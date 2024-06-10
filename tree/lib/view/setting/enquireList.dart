import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:td_app/view/common/appbar.dart';

// ignore: must_be_immutable
class EnquireList extends StatelessWidget {
  EnquireList({super.key});

  // Property
  final box = GetStorage();
  String userEmail = '';


  // ---- View 1 ----
  // Widget _builder(context){
  //   return Scaffold(
  //     body: StreamBuilder(
  //       stream: FirebaseFirestore.instance
  //               .collection('enquire')
  //               // .orderBy(field),
  //               .where('email', isEqualTo: userEmail)
  //               .snapshots(), 
  //       builder: (context, snapshot) {
  //         if (! snapshot.hasData) {
  //           return const Center(child: CircularProgressIndicator(),);
  //         }
  //         var documents = snapshot.data!.docs;
  //         return ListView(
  //           children: documents.map((e) => _bodyView(e, context)).toList(),
  //         );
  //       },
  //     ),
  //   );
  // }

  // ---- View 1 ----
  Widget _bodyView(context) {
    // final enquireList = ModelEnquire(title: doc['title'], context: doc['context'], date: doc['date'], image: doc['image']);
    return SizedBox(
      child: Dismissible(
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: const Icon(Icons.delete_forever),
        ),
        key: ValueKey(""),
        onDismissed: (direction) {
          // FirebaseFirestore.instance
          // .collection('enquire')
          // .doc(doc.id)
          // .delete();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Container(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "제목: 입력 제목 데이터 받아야함",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      initialValue: "입력 Content 내용",
                      maxLines: null, // 여러 줄 입력 가능하도록 설정
                      decoration: const InputDecoration(
                        hintText: "내용을 입력하세요",
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true, // 읽기 전용 모드로 설정
                    ),
                    const SizedBox(height: 16.0),
                    Text("날짜: 입력날짜 데이터 받아야함"),
                    // if (enquireList.image != null) 
                    //   Image.network(enquireList.image),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // userEmail = box.read('email');
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80), 
        child: CommonAppbar()
      ),
      body: _bodyView(context),
    );
  }
}