# cocoFarm

 혹시 팀 버전을 받고 merging?  상태에서 git status 를 했을 때<br>
  cocoFarm/target/....<br>
같은게 있으면<br>
  git rm -r --cached cocoFarm/target/<br>
를 써 주세요.<br><br>
 데이터 구조는 항상 최신으로 유지하세요.<br>
개인적으로 더미 데이터가 따로 필요하면, insert하는 구문들을 따로 개인 폴더를 만들어서 저장하거나<br>
  sql파일의 더미 데이터 모아두는 부분에 끼워넣고 작업하시면 됩니다.<br><br>
 개인적으로 중간중간 commit하는 것은 되도록이면 자기 저장소에 하세요.<br>
작업하던 내용의 한 단계가 완성이 되고 다른 부분에 문제가 생기지 않은 상태로 올리세요.<br>
팀 버전(혹은 다른 어떤 프로젝트) 를 받고 에러가 나면<br>
  1. 프로젝트 우클릭 -> refresh<br>
  2. 이클립스 서버에 우클릭 하고 clean/clean tomcat directory<br>
  3. 프로젝트 클릭, 이클립스 위쪽 메뉴 project->clean<br>
