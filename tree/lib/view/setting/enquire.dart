import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:td_app/view/common/appbar.dart';

class Enquire extends StatelessWidget {
  Enquire({super.key});

  // Property
  final TextEditingController titleCon = TextEditingController();
  final TextEditingController contextCon = TextEditingController();
  final TextEditingController dateCon = TextEditingController();
  // String userEmail = '';
  final box = GetStorage();

  // // ---- View 1 ----
  // Widget _bodyView(context){
  //   return TextButton(
  //     onPressed: () {
        
  //     }, 
  //     child: Text(
  //       '문의완료',
  //       style: TextStyle(
  //         fontSize: 20,
  //         fontWeight: FontWeight.bold,
  //         color: Theme.of(context).colorScheme.tertiary
  //       ),
  //     ),
  //   ); 
  // }

  // ---- View 1 ----
  Widget _bodyView(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          
          
          // 제목
          Padding(
            padding: const EdgeInsets.fromLTRB(40,50,40,20),
            child: TextField(
              controller: titleCon,
              decoration: const InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
                )
              ),
            ),
          ),
            
            
          // context
          SizedBox(
            height: 290,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40,0,40,0),
              child: TextField(
                maxLines: 10,
                controller: contextCon,
                decoration: const InputDecoration(
                  labelText: '내용',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                  )
                ),
              ),
            ),
          ),

          // 사진 선택
          Padding(
            padding: const EdgeInsets.fromLTRB(0,15,0,0),
            child: ElevatedButton(
              onPressed: () {
            
              },
              // => provider.chooseFromGallery(ImageSource.gallery), 
              child: const Text('사진 선택'),
            ),
          ),


          // 이미지 담는 박스
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: const Center(
                child: 
                // child: provider.checkNewImage
                // ? Image.file(File(provider.selectedImg.path))
                // : 
                Text('there is no image...')
              ),
            ),
          ),

          // 문의 완료 버튼
          // ElevatedButton(
          //   onPressed: () {
          //     provider = titleCon.text;
          //     provider.insertEnquire();

          //   }, 
          //   child: const Text('문의완료')
          // ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80), 
        child: CommonAppbar()
      ),
      body: _bodyView(context),
    );
  }
}