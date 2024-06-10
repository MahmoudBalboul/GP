import 'package:agarly/HomeScreen.dart';
import 'package:agarly/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required String title, required String rentBuyOption}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  String? _emailErrorMessage;
  String? _passwordErrorMessage;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 233, 188, 124),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 233, 188, 124), Color(0xFFFFFFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/Group_2.png',
                      width: 250.0,
                      height: 250.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 40.0,
                        height: 2.15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.59,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF000000),
                          letterSpacing: 0.08,
                        ),
                      ),
                      if (_emailErrorMessage != null)
                        Text(
                          _emailErrorMessage!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                          ),
                        ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.50),
                          border: Border.all(
                              color: const Color.fromARGB(255, 134, 87, 19)),
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Please Enter Your Email',
                            labelStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 7.0),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.59,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF000000),
                          letterSpacing: 0.08,
                        ),
                      ),
                      if (_passwordErrorMessage != null)
                        Text(
                          _passwordErrorMessage!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                          ),
                        ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.50),
                          border: Border.all(
                              color: const Color.fromARGB(255, 134, 87, 19)),
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Please Enter Your Password',
                            labelStyle:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 7.0),
                          ),
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _validateAndSignIn();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 238, 205, 160),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 241, 229, 212)),
                          ),
                        ),
                        child: const Text('Login',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.59,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF000000),
                          letterSpacing: 0.08,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInPage()),
                          );
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.59,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            letterSpacing: 0.08,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  Center(
                    child: CustomSwitch(
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateAndSignIn() {
    setState(() {
      _emailErrorMessage =
          _emailController.text.isEmpty ? 'Email cannot be empty.' : null;
      _passwordErrorMessage =
          _passwordController.text.isEmpty ? 'Password cannot be empty.' : null;
    });

    if (_emailErrorMessage == null && _passwordErrorMessage == null) {
      _signInWithEmailAndPassword();
    }
  }

  void _signInWithEmailAndPassword() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeScreen(
                    rentBuyOption: '_rentBuyIndex',
                    title: '',
                  )));
    }).catchError((error) {
      setState(() {
        _errorMessage = 'Invalid email or password. Please try again.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      });
    });
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.value;
  }

  @override
  void didUpdateWidget(CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _isChecked = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
          widget.onChanged(_isChecked);
        });
      },
      child: Container(
        width: 85,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(115),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 28,
              offset: Offset(0, 30),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 22,
              offset: Offset(-28, 28),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 0,
              offset: Offset(0, 30),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 0,
              offset: Offset(0, 1),
            
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: _isChecked ? null : 10.0,
              right: _isChecked ? 10.0 : null,
              child: Text(
                _isChecked ? 'OFF' : 'ON',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _isChecked ? Colors.white : Color(0xFF636161),
                  fontSize: 17,
                  fontFamily: 'sans-serif',
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 1,
                      color: Colors.black,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
              left: _isChecked ? 50 : 0,
              right: _isChecked ? 0 : 50,
              top: 4,
              bottom: 4,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: _isChecked ? Color(0xFF232323) : Colors.black,
                  borderRadius: BorderRadius.circular(400),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, -3),
                     
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 200,
                      offset: Offset(0, -200),
                      
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _isChecked ? Color(0xFF232323) : Colors.black,
                      borderRadius: BorderRadius.circular(400),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(1),
                          blurRadius: 8,
                          offset: Offset(8, -4),
                        
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(1),
                          blurRadius: 8,
                          offset: Offset(-8, -4),
                        
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(1),
                          blurRadius: 4,
                          offset: Offset(0, 3),
                   
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 200,
                          offset: Offset(0, -200),
                  
                        ),
                        BoxShadow(
                          color: Color(0xFFB4B4B4).withOpacity(0.2),
                          blurRadius: 200,
                          offset: Offset(0, -200),
                  
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
