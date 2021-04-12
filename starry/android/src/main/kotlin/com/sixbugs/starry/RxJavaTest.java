package com.sixbugs.starry;

import io.reactivex.Observable;
import io.reactivex.ObservableSource;
import io.reactivex.Observer;
import io.reactivex.annotations.NonNull;
import io.reactivex.disposables.Disposable;
import io.reactivex.functions.Function;

public class RxJavaTest {
    public static void main(String[] args) {

        // 1->"1"->1->"1" map可以进行多次数据转换，返回的不是Observable
        Observable.just(1).map(new Function<Integer, String>() {
            @Override
            public String apply(@NonNull Integer integer) throws Exception {
                return String.valueOf(integer);
            }
        }).map(new Function<String, Integer>() {
            @Override
            public Integer apply(@NonNull String s) throws Exception {
                return Integer.valueOf(s);
            }
        }).map(new Function<Integer, String>() {
            @Override
            public String apply(@NonNull Integer integer) throws Exception {
                return String.valueOf(integer);
            }
        }).subscribe(new Observer<String>() {
            @Override
            public void onSubscribe(@NonNull Disposable d) {
                System.out.println("======onSubscribe");
            }

            @Override
            public void onNext(@NonNull String s) {
                System.out.println("======onNext"+s);
            }

            @Override
            public void onError(@NonNull Throwable e) {
                System.out.println("======onError");
            }

            @Override
            public void onComplete() {
                System.out.println("======onComplete");

            }
        });


        ///flatMap
        Observable.just(getUserParams()).flatMap(new Function<UserParams, ObservableSource<?>>() {
            @Override
            public ObservableSource<?> apply(@NonNull UserParams userParams) throws Exception {
                ///去登陆，返回token..

                return null;
            }
        });


    }

    private static UserParams getUserParams(){
        return  null;
    }


    class UserParams {
        private int userId;
        private String userPass;

        public UserParams(int userId, String userPass) {
            this.userId = userId;
            this.userPass = userPass;
        }

        public int getUserId() {
            return userId;
        }

        public void setUserId(int userId) {
            this.userId = userId;
        }

        public String getUserPass() {
            return userPass;
        }

        public void setUserPass(String userPass) {
            this.userPass = userPass;
        }
    }


    class  User{
        int userId;

        public int getUserId() {
            return userId;
        }

        public void setUserId(int userId) {
            this.userId = userId;
        }
    }
    class UserInfo{
        private String userName;

        public String getUserName() {
            return userName;
        }

        public void setUserName(String userName) {
            this.userName = userName;
        }
    }
}
