Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 417DE5BDE1
	for <lists+linux-sctp@lfdr.de>; Mon,  1 Jul 2019 16:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfGAOPY (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 1 Jul 2019 10:15:24 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:44417 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfGAOPY (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 1 Jul 2019 10:15:24 -0400
Received: by mail-io1-f41.google.com with SMTP id s7so29078757iob.11
        for <linux-sctp@vger.kernel.org>; Mon, 01 Jul 2019 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=arc/2beSbMZ/NsThoabnNtSzyLfP3kbDL2+t7ju4qPE=;
        b=GRXBaA2OKA7RitTF09Ai0KnBCDEELql9rB+q3M5wfbTZfLHj+cnhhGyss8QXL+zTlT
         mzq/5AJ7hAIMo4oz7tvJ8WAZtX2f0CXUYhJZbe9Oy8yzqPq/sxFQ2kzbMsJLbcQYY84j
         zpQsVhTiIzt85HKEtbemBZ9SSRR9HAgZJAhudlxfUC40veoCCJi6qBkuKjOpmzaTAw75
         6fIuwuUOHnkHfgNcVc1nls+GM7XJaP8lde7faF3lPUDB2GAmx3/gPnvqlFjW3KPYGMM7
         zMKboALDpBgPZmSFTuLgNfaX2zApbQkSy3s2EV4d28bg3vJiShRF2Nk5yKWmUJCFh8xW
         yykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=arc/2beSbMZ/NsThoabnNtSzyLfP3kbDL2+t7ju4qPE=;
        b=i4OAXWQD2U/JoznSb8V2BP7ht5TeyBNTHiGT3+28E8ox+uKGAiY+aQnuXTPEQoJb0A
         xjQ1G7/DVf6YIj/LGSSdH6YRatXLO1mwECGegV5uRLZHuPV4C73WQufE0ZhMSzz9I3fu
         ddwq8zUgdb4iMF4pgUOk5Sb+dsbmrJQVJ38TxSnYXh4d3Ja9lGsofrW0L3CX8xlzpJXd
         0NYqVo0DmPxxTTBpqUWNL61zef4DUsfF4pLgYYV5/bC1/r+h8Lz14XcOxLAE6kQXTaYn
         O3gOOqYtKB1NtRgXlXIQio4M32AKZtR6kU+HajEPDnnMv5t6oWLPnEIyfuA2wMRgbcgP
         mabg==
X-Gm-Message-State: APjAAAV51DNFvWx9pjaF1ZYDLg/vNcJ8y+VfJwuz2rdIdBB1mjjViBFr
        ywPHoLxfhsBVqI1LvXCGkOLpNq6gKSwHv5iKFSjIpg==
X-Google-Smtp-Source: APXvYqyQy3NkQ0wIt2fDbyCN8jdxoCDHwvHI/lfq6Z4UXxj/a8E6yfsp5e6aR8k1BYv9snE1Hags6F5iSylPd3HvQhc=
X-Received: by 2002:a6b:7017:: with SMTP id l23mr23934918ioc.159.1561990523357;
 Mon, 01 Jul 2019 07:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHVEBDeOjt7LbMk=aP1QOzowtxvR+iLKgxM37bXTr=2GEhTu6w@mail.gmail.com>
 <CADvbK_cdjw+a-HoBuuop7njwCwrrkV2_oSWiv5zF-UngxnUbtw@mail.gmail.com>
In-Reply-To: <CADvbK_cdjw+a-HoBuuop7njwCwrrkV2_oSWiv5zF-UngxnUbtw@mail.gmail.com>
From:   TJ Corley <tjcorley30@gmail.com>
Date:   Mon, 1 Jul 2019 10:14:48 -0400
Message-ID: <CAHVEBDcPKeF7aK520Br-JPRVga_U-st4dZYVSrjiHA1m7Ha3fg@mail.gmail.com>
Subject: Re: Unable to call SCTP_ADD_STREAMS twice?
To:     Xin Long <lucien.xin@gmail.com>
Cc:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

That worked perfectly.

Thanks!

On Mon, Jul 1, 2019 at 4:29 AM Xin Long <lucien.xin@gmail.com> wrote:
>
> On Sat, Jun 29, 2019 at 4:34 AM TJ Corley <tjcorley30@gmail.com> wrote:
> >
> > I am creating a library and it appears I am unable to call setsockopt
> > with the option SCTP_ADD_STREAMS on the same same socket twice. On the
> > second attempt it will return EINPROGRESS no matter what. It appears
> > this is happening due to the fact that
> > asoc->strreset_outstanding is still set. However if I am reading the
> > code correctly when I call the socket option sctp_send_reconf will be
> > called with a param of type SCTP_PARAM_RESET_ADD_OUT_STREAMS which
> > should eventually trigger the chain of  sctp_sf_do_reconf
> > ->sctp_process_strreset_outreq which will decrement
> > asoc->strreset_outstanding.
> >
> > I have SCTP_RECONFIG_SUPPORTED enabled and SCTP_ENABLE_RESET set to
> > SCTP_ENABLE_CHANGE_ASSOC_REQ | SCTP_ENABLE_RESET_STREAM_REQ |
> > SCTP_ENABLE_RESET_ASSOC_REQ on all the relevant sockets. Is there
> > anything else I should be doing?
> Yes, you need to do:
>
> # sysctl -w net.sctp.reconf_enable=1
>
> which is like a main switch for all sctp socket.
>
> >
> > I have included my sample code below that triggers this behavior.
> >
> > Thanks for all the help,
> >
> > TJ
> >
> > #include <arpa/inet.h>
> > #include <errno.h>
> > #include <linux/sctp.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <sys/socket.h>
> > #include <sys/uio.h>
> > #include <unistd.h>
> >
> > int allow_reconfigure_support(int fd) {
> >   struct sctp_assoc_value params;
> >
> >   params.assoc_value = 1;
> >   params.assoc_id = 0;
> >   return setsockopt(fd, IPPROTO_SCTP, SCTP_RECONFIG_SUPPORTED, &params,
> >                     sizeof(params));
> > }
> >
> > int allow_reset(int fd) {
> >
> >   struct sctp_assoc_value params;
> >
> >   params.assoc_id = 0;
> >   params.assoc_value = SCTP_ENABLE_CHANGE_ASSOC_REQ |
> >                        SCTP_ENABLE_RESET_STREAM_REQ |
> >                        SCTP_ENABLE_RESET_ASSOC_REQ;
> >
> >   return setsockopt(fd, IPPROTO_SCTP, SCTP_ENABLE_STREAM_RESET, &params,
> >                     sizeof(params));
> > }
> >
> > int add_streams(int fd, int num_streams) {
> >
> >   struct sctp_add_streams addstr;
> >   addstr.sas_outstrms = num_streams;
> >   addstr.sas_instrms = 0x00;
> >   addstr.sas_assoc_id = 0;
> >
> >   return setsockopt(fd, IPPROTO_SCTP, SCTP_ADD_STREAMS, &addstr,
> >                     sizeof(addstr));
> > }
> >
> > int main() {
> >   struct sockaddr_in in, out;
> >   socklen_t out_len;
> >   int server;
> >   int client;
> >   int accept_fd;
> >   int err;
> >   memset(&in, '\x00', sizeof(in));
> >
> >   in.sin_family = AF_INET;
> >   in.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> >   in.sin_port = htons(12346);
> >
> >   server = socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);
> >   client = socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);
> >
> >   if (server == -1 || client == -1) {
> >     printf("socket(): %s\n", strerror(errno));
> >     return -1;
> >   }
> >
> >   if (allow_reconfigure_support(server)) {
> >     printf("server allow_reconfigure_support: %s\n", strerror(errno));
> >   }
> >
> >   if (allow_reset(client)) {
> >     printf("client allow_reset: %s\n", strerror(errno));
> >   }
> >
> >   if (allow_reconfigure_support(client)) {
> >     printf("client allow_reconfigure_support: %s\n", strerror(errno));
> >   }
> >
> >   if (allow_reset(client)) {
> >     printf("client allow_reset: %s\n", strerror(errno));
> >   }
> >
> >   printf("server fd: %d\n", server);
> >   printf("client fd: %d\n", client);
> >
> >   err = bind(server, (void *)&in, sizeof(in));
> >   if (err == -1) {
> >     printf("bind: %s\n", strerror(errno));
> >     return -1;
> >   }
> >
> >   err = listen(server, 1);
> >   if (err == -1) {
> >     printf("listen: %s\n", strerror(errno));
> >     return -1;
> >   }
> >
> >   err = connect(client, (void *)&in, sizeof(in));
> >   if (err == -1) {
> >     printf("connect: %s\n", strerror(errno));
> >     return -1;
> >   }
> >
> >   accept_fd = accept(server, (void *)&out, &out_len);
> >   if (accept_fd == -1) {
> >     printf("accept: %s\n", strerror(errno));
> >     return -1;
> >   }
> >   printf("accept_fd: %d\n", accept_fd);
> >
> >   if (allow_reconfigure_support(accept_fd)) {
> >     printf("accept_fd allow_reconfigure_support: %s\n", strerror(errno));
> >   }
> >
> >   if (allow_reset(accept_fd)) {
> >     printf("accept_fd allow_reset: %s\n", strerror(errno));
> >   }
> >
> >   err = add_streams(accept_fd, 0x10);
> >   if (err == -1) {
> >     printf("add_streams: %s\n", strerror(errno));
> >     return -1;
> >   }
> >
> >   sleep(1);
> >
> >   err = add_streams(accept_fd, 0x10);
> >   if (err == -1) {
> >     printf("add_streams2: %s\n", strerror(errno));
> >     return -1;
> >   }
> >
> >   printf("finished no errors\n");
> > }
