package com.sweater.service;

import com.sweater.domain.Role;
import com.sweater.domain.User;
import com.sweater.repos.RoleRepo;
import com.sweater.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private RoleRepo roleRepo;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private MyMailSender mailSender;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username);

        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }

        return user;
    }

    public boolean addUser(User user){
        User userFromDb = userRepo.findByUsername(user.getUsername());

        if(userFromDb != null){
             return false;
        }

        user.setActive(false);
        user.setRoles(List.of(roleRepo.findById(1L).get()));
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setActivationCode(UUID.randomUUID().toString());

        userRepo.save(user);

        if(!StringUtils.isEmpty(user.getEmail())){
            String message = String.format(
                    "Hello, %s! \n" +
                            "Welcome to Sweater, Please, visit next link: http://localhost:8080/activate/%s",
                user.getUsername(), user.getActivationCode()
            );
            String subject = "Activation code";

            mailSender.send(user.getEmail(), subject, message);
        }

        return true;
    }

    public boolean activateUser(String code) {
        User user = userRepo.findByActivationCode(code);

        if(user == null){
            return false;
        }

        user.setActive(true);
        user.setActivationCode(null);

        userRepo.save(user);
        return true;
    }

    public void userDeleteAdmin(User user){
        userRepo.deleteById(user.getId());
    }

    public List<User> findAll() {
        return userRepo.findAll();
    }

    public List<Role> findAllRole() {
        return roleRepo.findAll();
    }

    public void userSave(User user, String username, Map<String, String> form) {
        user.setUsername(username);

        List<String> roles = roleRepo.findAll().stream()
                .map(role -> role.getRole()).toList();

        user.getRoles().clear();

        for (String key : form.keySet()){
            if(roles.contains(key)){
                user.getRoles().add(roleRepo.findByRole(key).get());
            }
        }

        if(form.containsKey("status")){
            user.setActive(true);
        } else {
            user.setActive(false);
        }

        userRepo.save(user);
    }

    public int updateEmail(User user, String email){
        String userEmail = user.getEmail();

        boolean isEmailChanged = !email.equals(userEmail);

        if(isEmailChanged){
            if(emailValidation(email)){
                user.setEmail(email);

                if(!StringUtils.isEmpty(email)){
                    user.setActivationCode(UUID.randomUUID().toString());
                }
                userRepo.save(user);

                String message = String.format("Hello, %s! \n" +
                        "Your email has been changed to this one!\nSincerely, the sweater team.",
                        user.getUsername());

                String subject = "Update email";
                mailSender.send(user.getEmail(), subject, message);
                return 2;
            } else {
                return 1;
            }
        } else {
            return 0;
        }
    }

    public int updatePassword(User user,  String oldPassword, String newPassword){
        if(!StringUtils.isEmpty(newPassword) && !StringUtils.isEmpty(oldPassword)){
            if(passwordEncoder.matches(oldPassword, user.getPassword())){
                user.setPassword(passwordEncoder.encode(newPassword));
                userRepo.save(user);
                return 2;
            } else {
                return 1;
            }
        } else {
            return 0;
        }
    }

    private boolean emailValidation(String emailAddress) {
        return Pattern.compile("^(.+)@(\\S+)$")
                .matcher(emailAddress)
                .matches();
    }
}
