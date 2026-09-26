import pty, os, sys, time

pid, fd = pty.fork()
if pid == 0:
    os.execvp("ssh", ["ssh", "-o", "StrictHostKeyChecking=no", "ubuntu@localhost"] + sys.argv[1:])
else:
    output = b""
    while True:
        try:
            data = os.read(fd, 1024)
            if b"assword:" in data:
                os.write(fd, b"qwerty@1111\n")
            else:
                output += data
        except OSError:
            break
    print(output.decode(errors='ignore'))
