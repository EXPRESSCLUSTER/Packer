# Packer

## Table of Contents

* [Evaluation Environment](#evaluation-environment)
* [Installing libvirt, KVM and Packer](#installing-libvirt-kvm-and-packer)
* [Building Vagrant box](#building-vagrant-box)
* [References](#references)


## Evaluation Environment

* Host machine (on OCI)
  * Oracle Linux 8.7
  * Packer 1.8.5
  * libvirtd 8.0.0


## Installing libvirt, KVM and Packer

1. Confirm a CPU in the environment supports virtualization 
   ```
   $ lscpu | grep svm
   Flags:               fpu (snip) svm (snip) arch_capabilities
   ```

1. Apply latest packages.
   ```
   $ sudo dnf update
   ```

1. Install libvirt and KVM packages.
   ```
   $ sudo dnf install qemu-kvm libvirt
   ```

1. Configure libvirtd.
   ```
   $ sudo vi /etc/libvirt/libvirtd.conf   # edit the following parameters
   ---
   unix_sock_group = "libvirt"
   unix_sock_rw_perms = "0770"
   ---

   $ sudo usermod -G libvirt -a opc
   $ sudo systemctl restart libvirtd
   ```

1. Install Packer.
   ```
   $ sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
   $ sudo dnf install packer
   ```

## Building Vagrant box

1. Clone this repository.
   ```
   $ git clone https://github.com/EXPRESSCLUSTER/Packer packer-test
   $ cd packer-test
   ```

1. Place RHEL 8.4 ISO image (rhel-8.4-x86_64-dvd.iso) and EXPRESSCLUSTER files (rpm and license keys).
   ```
   $ mv /path/to/files .
   $ ls
   base-license.key               README.md         rhel-8.4-x86_64-dvd.iso
   docroot                        repl-license.key  scripts
   expresscls-5.0.2-1.x86_64.rpm  rhel84-ecx.json   Vagrantfile
   ```

1. Start packer build.
   ```
   $ packer build rhel84-ecx.json
   ```

1. Check the generated file.
   ```
   $ ls rhel84-ecx.box
   ```

* [Trouble shooting] If you get an error of "Failed creating Qemu driver: exec: "qemu-system-x86_64": executable file not found in $PATH"
  * Create a symbolic link and add PATH as below.
    ```
    $ sudo ln -s /usr/libexec/qemu-kvm /usr/libexec/qemu-system-x86_64
    $ PATH="$PATH:/usr/libexec"
    ```


## References

* https://github.com/sdorsett/packer-centos7-esxi
* https://github.com/stardata/packer-centos7-kvm-example
* https://github.com/ansiblejunky/packer-rhel
