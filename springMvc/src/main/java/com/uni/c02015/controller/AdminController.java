package com.uni.c02015.controller;

import com.uni.c02015.SpringMvc;
import com.uni.c02015.domain.Landlord;
import com.uni.c02015.domain.Message;
import com.uni.c02015.domain.Searcher;
import com.uni.c02015.domain.User;
import com.uni.c02015.domain.property.Property;
import com.uni.c02015.persistence.repository.*;
import com.uni.c02015.persistence.repository.property.PropertyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

@Controller
public class AdminController {

  @Autowired
  private MessageRepository messageRepo;
  @Autowired
  private UserRepository userRepo;
  @Autowired
  private PropertyRepository propertyRepo;
  @Autowired
  private SearcherRepository searcherRepo;
  @Autowired
  private LandlordRepository landlordRepo;
  @Autowired
  private RoleRepository roleRepo;
  @Autowired
  private VerificationTokenRepository tokenRepo;

  /**
   * Broadcast multiple messages to users.
   * @param request HttpServletRequest
   * @return String
   */
  @RequestMapping("/admin/broadcast/send")
  public String broadcast(HttpServletRequest request) {

    String subject = request.getParameter("subject");
    String message = request.getParameter("message");
    String sendTo = request.getParameter("sendTo");

    // Form error
    if (sendTo.length() == 0 || subject.length() == 0 || message.length() == 0) {

      return "redirect:/admin/broadcast/message?error=true";
    }

    // Get the user
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String username = auth.getName();
    User currentUser = userRepo.findByLogin(username);

    // Sending to all users
    if (sendTo.equals("all")) {

      ArrayList<User> allUsers = (ArrayList<User>) userRepo.findAll();
      for (User user : allUsers) {
        Message messageObj = new Message();
        messageObj.setSenderName(currentUser.getLogin());
        messageObj.setSender(currentUser);
        messageObj.setReceiver(user);
        messageObj.setSubject(request.getParameter("subject"));
        messageObj.setMessage(request.getParameter("message"));
        messageObj.setMessageDate(new Date());
        messageObj.setIsRead(false);
        messageRepo.save(messageObj);
      }

    // Sending to searchers
    } else if (sendTo.equals("searchers")) {

      ArrayList<Searcher> allUsers = (ArrayList<Searcher>) searcherRepo.findAll();
      for (Searcher user : allUsers) {
        Message messageObj = new Message();
        messageObj.setSenderName(currentUser.getLogin());
        messageObj.setSender(currentUser);
        messageObj.setReceiver(userRepo.findById(user.getId()));
        messageObj.setSubject(request.getParameter("subject"));
        messageObj.setMessage(request.getParameter("message"));
        messageObj.setMessageDate(new Date());
        messageObj.setIsRead(false);
        messageRepo.save(messageObj);
      }

    // Sending to landlords
    } else if (sendTo.equals("landlords")) {

      ArrayList<Landlord> allUsers = (ArrayList<Landlord>) landlordRepo.findAll();
      for (Landlord user : allUsers) {
        Message messageObj = new Message();
        messageObj.setSenderName(currentUser.getLogin());
        messageObj.setSender(currentUser);
        messageObj.setReceiver(userRepo.findById(user.getId()));
        messageObj.setSubject(request.getParameter("subject"));
        messageObj.setMessage(request.getParameter("message"));
        messageObj.setMessageDate(new Date());
        messageObj.setIsRead(false);
        messageRepo.save(messageObj);
      }
    }

    return "redirect:/admin/broadcast/message?success=true";
  }

  /**
   * Mass message view.
   * @param request HttpServletRequest
   * @return ModelAndView
   */
  @RequestMapping("/admin/broadcast/message")
  public ModelAndView massMessage(HttpServletRequest request) {

    ModelAndView modelAndView = new ModelAndView("/administrator/broadcast");

    // Get the request GET parameters and add to the model
    Map<String, String[]> parameters = request.getParameterMap();
    modelAndView.addAllObjects(parameters);

    return modelAndView;
  }

  /**
   * View all properties.
   * @param request HttpServletRequest
   * @return ModelAndView
   */
  @RequestMapping("/admin/viewProperties")
  public ModelAndView viewProperties(HttpServletRequest request) {

    // Get the request GET parameters
    Map<String, String[]> parameters = request.getParameterMap();

    // Create the model and view and add the GET parameters as object in the model
    ModelAndView modelAndView = new ModelAndView("/administrator/view-properties");
    modelAndView.addAllObjects(parameters);

    ArrayList<Property> properties = (ArrayList<Property>) propertyRepo.findAll();
    modelAndView.addObject("properties", properties);

    return modelAndView;
  }

  /**
   * View all users.
   * @param request HttpServletRequest
   * @return ModelAndView
   */
  @RequestMapping("/admin/viewUsers")
  public ModelAndView viewUsers(HttpServletRequest request) {

    // Get the request GET parameters
    Map<String, String[]> parameters = request.getParameterMap();

    // Create the model and view and add the GET parameters as object in the model
    ModelAndView modelAndView = new ModelAndView("/administrator/view-users");
    modelAndView.addAllObjects(parameters);

    ArrayList<User> users = (ArrayList<User>) userRepo.findAll();
    modelAndView.addObject("users", users);

    return modelAndView;
  }

  /**
   * Delete a property.
   * @param id Property Id
   * @return String
   */
  @RequestMapping("/admin/property/delete/{id}")
  public String deleteProperty(@PathVariable Integer id) {

    Property property = propertyRepo.findById(id);

    if (property != null) {

      propertyRepo.delete(id);

      return "redirect:/admin/viewProperties?deleted=true";
    }

    return "redirect:/admin/viewProperties";
  }

  /**
   * Suspend a user.
   * @param id User Id
   * @return String
   */
  @RequestMapping("/admin/user/suspend/{id}")
  public String suspendUser(@PathVariable Integer id) {

    User user = userRepo.findById(id);
    if (user != null) {

      user.setSuspended(true);
      userRepo.save(user);

      return "redirect:/admin/viewUsers?suspended=true";
    }

    return "redirect:/admin/viewUsers";
  }

  /**
   * Unsuspend a user.
   * @param id User Id
   * @return String
   */
  @RequestMapping("/admin/user/unSuspend/{id}")
  public String unSuspendUser(@PathVariable Integer id) {

    User user = userRepo.findById(id);

    if (user != null && user.isSuspended()) {

      user.setSuspended(false);
      userRepo.save(user);

      return "redirect:/admin/viewUsers?unSuspended=true";
    }

    return "redirect:/admin/viewUsers";
  }

  /**
   * Delete a user.
   * @param id User Id
   * @return String
   */
  @RequestMapping("/admin/user/delete/{id}")
  public String deleteUser(@PathVariable Integer id) {

    User user = userRepo.findById(id);
    if (user != null) {

      messageRepo.delete(messageRepo.findBySender(user));
      tokenRepo.delete(tokenRepo.findByUser(user));
      userRepo.delete(user);

      return "redirect:/admin/viewUsers?deleted=true";
    }

    return "redirect:/admin/viewUsers";
  }

  /**
   * View a user.
   * @param id User Id
   * @return ModelAndView
   */
  @RequestMapping("/admin/view-user/{id}")
  public ModelAndView viewUser(@PathVariable Integer id) {

    User user = userRepo.findById(id);

    if (user != null) {

      ModelAndView modelAndView = new ModelAndView("/administrator/view-user", "user" , new User());

      if (user.getRole().getId() == SpringMvc.ROLE_SEARCHER_ID) {

        Searcher searcher = searcherRepo.findById(user.getId());
        modelAndView.addObject("searcher", searcher);

      } else if (user.getRole().getId() == SpringMvc.ROLE_LANDLORD_ID) {

        Landlord landlord = landlordRepo.findById(user.getId());
        modelAndView.addObject("landlord", landlord);

      } else {

        return new ModelAndView("redirect:/admin/viewUsers");
      }

      modelAndView.addObject("usr", user);
      return modelAndView;
    }
    return new ModelAndView("redirect:/admin/viewUsers");
  }

  /**
   * Edit a user.
   * @param id User Id
   * @param firstName User first name
   * @param lastName User last name
   * @param emailAddress User email address
   * @param buddy Buddy preference
   * @return String
   */
  @RequestMapping("/admin/user/edit")
  public String editUser(@RequestParam("id") Integer id,
                         @RequestParam("firstName") String firstName,
                         @RequestParam("lastName") String lastName,
                         @RequestParam("emailAddress") String emailAddress,
                         @RequestParam(value = "buddyPref", required = false) Boolean buddy) {

    User user = userRepo.findById(id);
    user.setEmailAddress(emailAddress);

    if (user.getRole().getId() == SpringMvc.ROLE_SEARCHER_ID) {

      Searcher searcher = searcherRepo.findById(id);
      searcher.setFirstName(firstName);
      searcher.setLastName(lastName);
      searcher.setBuddyPref(buddy);
      searcherRepo.save(searcher);

    } else if (user.getRole().getId() == SpringMvc.ROLE_LANDLORD_ID) {

      Landlord landlord = landlordRepo.findById(user.getId());
      landlord.setFirstName(firstName);
      landlord.setLastName(lastName);
      landlordRepo.save(landlord);
    }

    userRepo.save(user);

    return "redirect:/admin/viewUsers?edited=true";
  }
}