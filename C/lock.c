// Uses a private API. compile using:
// clang -F /System/Library/PrivateFrameworks -framework login
 
 
extern void SACLockScreenImmediate();

int main(){
    SACLockScreenImmediate();
    return 0;
}
