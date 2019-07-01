Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484F45B6DA
	for <lists+linux-sctp@lfdr.de>; Mon,  1 Jul 2019 10:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfGAI3e (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 1 Jul 2019 04:29:34 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:40719 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfGAI3d (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 1 Jul 2019 04:29:33 -0400
Received: by mail-wm1-f44.google.com with SMTP id v19so14845265wmj.5
        for <linux-sctp@vger.kernel.org>; Mon, 01 Jul 2019 01:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6m/1tSnPedm0Nqvg18l8Zlh/Q3/cn0wMOrE3Alllps=;
        b=Kn6TbYPblQpnKhyEt4vi+Ehbfr1eEbcvM8RFbk1+Ww4jETxKZUTfdJODVWtwmL5cXd
         WTNN7fz6VRx+F2M56W/n/rM3qrC2SyQSjgg8FBXCmYvpahX6hA10Le8JGEQHkb1MAuLo
         OA7tGN7TzOy3aPA/TIBKmJhHfdfH3aO/0i5JBKqpUHl1aTlXax4Eyw1xW3+ppMqGsyQd
         IsaLGAhUh0cDw3DKquqiAd+3gJW0/Q68zDsr2nUWdfwrMfvVcUasW53a4O/O3ghSlQ3d
         UVqblsQpl+/FqfzFPI2qLkZRH0CzTtJ1kDyp5gh9aoTkvU4g70p0PyOi+tzyL1EkxYZp
         sTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6m/1tSnPedm0Nqvg18l8Zlh/Q3/cn0wMOrE3Alllps=;
        b=iDKM60BaIwEklPpBBiqglj0iYhol9jCZbE8pGX+gnlGQ/E6Vh6jZTt7pKP3Woa+pYT
         keF/SE2YJNE/nHY2Xzy5Jb0fGpJfyboB2iekzfl98E3yIDeJJTmcEFv9sP5oSdQLMvQ/
         Rp4ynBGY9SKJ2j3XLNkY0gFNqpicV8f7pqzAREEotRmLSC9ZPe4kzvcUMSdVc2U4E/U8
         tZ79fP8GPg7O3mhiy9dlCQZhwQAb9mU91u8rg2Y3ZxkDfAT5LoWWXcCbQIDxDZp9ttjF
         dpGY7rolVUdRyREkQLPerHJUDk/kmBq7GqVScKqa/WIFZSxiMicNqh44xTo1NAkuXqW0
         0M7A==
X-Gm-Message-State: APjAAAUhORNPDu5WxINQQyJlhAYbLwaRYWN2xPAJMgUcNN3wsEzPWCTd
        x3CJ9CBXUooTn83CBlPiZs3UZq7jTeqrUjiSXq6XOxXQ
X-Google-Smtp-Source: APXvYqxzkFIq/Kfx3VdzK1TiWvi4tgRai3ILWzEdJLJQLxbAHUrWQCjdb5UVPam5YMvkYrMTzyXYD0R3h16GrpH6uhw=
X-Received: by 2002:a1c:228b:: with SMTP id i133mr16461663wmi.140.1561969771091;
 Mon, 01 Jul 2019 01:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHVEBDeOjt7LbMk=aP1QOzowtxvR+iLKgxM37bXTr=2GEhTu6w@mail.gmail.com>
In-Reply-To: <CAHVEBDeOjt7LbMk=aP1QOzowtxvR+iLKgxM37bXTr=2GEhTu6w@mail.gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 1 Jul 2019 16:29:20 +0800
Message-ID: <CADvbK_cdjw+a-HoBuuop7njwCwrrkV2_oSWiv5zF-UngxnUbtw@mail.gmail.com>
Subject: Re: Unable to call SCTP_ADD_STREAMS twice?
To:     TJ Corley <tjcorley30@gmail.com>
Cc:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sat, Jun 29, 2019 at 4:34 AM TJ Corley <tjcorley30@gmail.com> wrote:
>
> I am creating a library and it appears I am unable to call setsockopt
> with the option SCTP_ADD_STREAMS on the same same socket twice. On the
> second attempt it will return EINPROGRESS no matter what. It appears
> this is happening due to the fact that
> asoc->strreset_outstanding is still set. However if I am reading the
> code correctly when I call the socket option sctp_send_reconf will be
> called with a param of type SCTP_PARAM_RESET_ADD_OUT_STREAMS which
> should eventually trigger the chain of  sctp_sf_do_reconf
> ->sctp_process_strreset_outreq which will decrement
> asoc->strreset_outstanding.
>
> I have SCTP_RECONFIG_SUPPORTED enabled and SCTP_ENABLE_RESET set to
> SCTP_ENABLE_CHANGE_ASSOC_REQ | SCTP_ENABLE_RESET_STREAM_REQ |
> SCTP_ENABLE_RESET_ASSOC_REQ on all the relevant sockets. Is there
> anything else I should be doing?
Yes, you need to do:

# sysctl -w net.sctp.reconf_enable=1

which is like a main switch for all sctp socket.

>
> I have included my sample code below that triggers this behavior.
>
> Thanks for all the help,
>
> TJ
>
> #include <arpa/inet.h>
> #include <errno.h>
> #include <linux/sctp.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/socket.h>
> #include <sys/uio.h>
> #include <unistd.h>
>
> int allow_reconfigure_support(int fd) {
>   struct sctp_assoc_value params;
>
>   params.assoc_value = 1;
>   params.assoc_id = 0;
>   return setsockopt(fd, IPPROTO_SCTP, SCTP_RECONFIG_SUPPORTED, &params,
>                     sizeof(params));
> }
>
> int allow_reset(int fd) {
>
>   struct sctp_assoc_value params;
>
>   params.assoc_id = 0;
>   params.assoc_value = SCTP_ENABLE_CHANGE_ASSOC_REQ |
>                        SCTP_ENABLE_RESET_STREAM_REQ |
>                        SCTP_ENABLE_RESET_ASSOC_REQ;
>
>   return setsockopt(fd, IPPROTO_SCTP, SCTP_ENABLE_STREAM_RESET, &params,
>                     sizeof(params));
> }
>
> int add_streams(int fd, int num_streams) {
>
>   struct sctp_add_streams addstr;
>   addstr.sas_outstrms = num_streams;
>   addstr.sas_instrms = 0x00;
>   addstr.sas_assoc_id = 0;
>
>   return setsockopt(fd, IPPROTO_SCTP, SCTP_ADD_STREAMS, &addstr,
>                     sizeof(addstr));
> }
>
> int main() {
>   struct sockaddr_in in, out;
>   socklen_t out_len;
>   int server;
>   int client;
>   int accept_fd;
>   int err;
>   memset(&in, '\x00', sizeof(in));
>
>   in.sin_family = AF_INET;
>   in.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
>   in.sin_port = htons(12346);
>
>   server = socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);
>   client = socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);
>
>   if (server == -1 || client == -1) {
>     printf("socket(): %s\n", strerror(errno));
>     return -1;
>   }
>
>   if (allow_reconfigure_support(server)) {
>     printf("server allow_reconfigure_support: %s\n", strerror(errno));
>   }
>
>   if (allow_reset(client)) {
>     printf("client allow_reset: %s\n", strerror(errno));
>   }
>
>   if (allow_reconfigure_support(client)) {
>     printf("client allow_reconfigure_support: %s\n", strerror(errno));
>   }
>
>   if (allow_reset(client)) {
>     printf("client allow_reset: %s\n", strerror(errno));
>   }
>
>   printf("server fd: %d\n", server);
>   printf("client fd: %d\n", client);
>
>   err = bind(server, (void *)&in, sizeof(in));
>   if (err == -1) {
>     printf("bind: %s\n", strerror(errno));
>     return -1;
>   }
>
>   err = listen(server, 1);
>   if (err == -1) {
>     printf("listen: %s\n", strerror(errno));
>     return -1;
>   }
>
>   err = connect(client, (void *)&in, sizeof(in));
>   if (err == -1) {
>     printf("connect: %s\n", strerror(errno));
>     return -1;
>   }
>
>   accept_fd = accept(server, (void *)&out, &out_len);
>   if (accept_fd == -1) {
>     printf("accept: %s\n", strerror(errno));
>     return -1;
>   }
>   printf("accept_fd: %d\n", accept_fd);
>
>   if (allow_reconfigure_support(accept_fd)) {
>     printf("accept_fd allow_reconfigure_support: %s\n", strerror(errno));
>   }
>
>   if (allow_reset(accept_fd)) {
>     printf("accept_fd allow_reset: %s\n", strerror(errno));
>   }
>
>   err = add_streams(accept_fd, 0x10);
>   if (err == -1) {
>     printf("add_streams: %s\n", strerror(errno));
>     return -1;
>   }
>
>   sleep(1);
>
>   err = add_streams(accept_fd, 0x10);
>   if (err == -1) {
>     printf("add_streams2: %s\n", strerror(errno));
>     return -1;
>   }
>
>   printf("finished no errors\n");
> }
