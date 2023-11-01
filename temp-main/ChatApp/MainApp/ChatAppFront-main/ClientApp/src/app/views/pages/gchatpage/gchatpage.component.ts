import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ChatService } from '../../../services/chat/chat.service';
import { AuthService } from '../../../services/auth/auth.service';
import { Subscription } from 'rxjs';
import { ViewProfile } from 'src/app/models/view-profile.model';
import { SignalRService } from 'src/app/services/signalr/signal-r.service';
import { GsidebarComponent } from '../../layout/gsidebar/gsidebar.component';
import { GchatComponent } from '../../layout/gchat/gchat.component';

@Component({
    selector: 'app-gchatpage',
    standalone: true,
    templateUrl: './gchatpage.component.html',
    styleUrls: ['./gchatpage.component.css'],
    imports: [CommonModule, GchatpageComponent, GsidebarComponent, GchatComponent]
})
export class GchatpageComponent {
  conversation: boolean = false;
  Messages: string[] = [];
  conversations: any[] = [];
  currentUserId: any;
  currentUserName: any;
  otheruserName: string;
  imageFile: File;
  profile: ViewProfile;
  private subscription: Subscription;

  constructor(private chatService: ChatService, private authService: AuthService, private signalRService: SignalRService) {
    console.log("this is done", this.currentUserName);

    this.subscription = this.chatService.Username.subscribe((message) => {

      this.conversation = true;
    });
  }


  ngOnInit(): void {

    this.currentUserName = localStorage.getItem('username');

    this.authService.getdetails(this.currentUserName);

    this.chatService.GetUserId(this.currentUserName).subscribe((id) => {
      this.currentUserId = id;
    })


    this.chatService.Username.subscribe(data => {

      this.otheruserName = data;

      this.chatService.viewMessages(this.currentUserName, data).subscribe((message) => {
        this.conversations = message.reverse();
        console.log(this.conversations);
      }, (error) => {
        console.log("ff ", error)
      })
    })

    this.signalRService.hubConnection.on('recieveMessage', (msg) => {
      console.log(msg,"AFSHFSGDHEREH");
      this.conversations.unshift(msg);
      console.log(this.conversations, "afds");
    });
  }



  handleData(data: any[]) {
    console.log(data[1]);
    console.log(this.currentUserId);

    
    let value = {
      Content: data[0],
      SenderId: this.currentUserId,
      ReceiverId: data[1],
      DateTime: null,
      IsReply: 0,
      IsSeen: 0,
      RepliedToId: 0,
      Type: null,
      RepliedContent: '',
      Id: null
    }

    console.log(value);
    this.signalRService.hubConnection.invoke('sendMsg', value).catch((error) => console.log(error));
  }

  
  ngOnDestroy() {
    // Unsubscribe to avoid memory leaks
    this.subscription.unsubscribe();
  }
}
