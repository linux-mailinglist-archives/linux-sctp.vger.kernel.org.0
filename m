Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFBD5A5EB
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Jun 2019 22:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfF1Ud7 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 28 Jun 2019 16:33:59 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:41472 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfF1Ud7 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 28 Jun 2019 16:33:59 -0400
Received: by mail-io1-f43.google.com with SMTP id w25so15200209ioc.8
        for <linux-sctp@vger.kernel.org>; Fri, 28 Jun 2019 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AUM77fg223q/zTEUrjQ0uzMxYbRculUwrEvgrpGYbIs=;
        b=QrpnDKLcw/mkS5GnBSrX7F5De3Ed6eiAhjdAWTyw3kS3eBzBPiHb4PbwOjANNMYNk2
         oOVZe7JeUKcza3uNRPNUR0aW3WuHCqfzwdbtknnd5QdYkXWfWncLRQXIr5YQSJoOxD2O
         qUv2MWjLPoozH6tMUueF/V3mJz2Un/KB1/yY60km/xqAKBXt2piRDbOcyz5H+intExKb
         G4jkI55kK4ZS5AIfa/FwohcQHpteUvLANjC8FfN/3OlLcQt2+DjnwZGFuN3QaBMJ1IDp
         CR5QwmNtlluNFMMHHD6e9P6hf7pQ6Tfj/CGklmAyEwcSJIGh3yqwtbLvpaREBXiyfK1i
         KeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AUM77fg223q/zTEUrjQ0uzMxYbRculUwrEvgrpGYbIs=;
        b=WD80KSGmACSxn1k75kqFWkrxE3XmdtGpguKZ44FTktFqrNq93LwFjMvXsu6hgoOWWC
         du5uFs22+nWj4LncMtyisPq58799slBNca6DOIsT3w9tEOub9ovyn+tscpUu9eEaeFf5
         HPMSnBtz+nBRE7O1gavWGG4ahhpGutw/sBBVgBDr83wzqlTZA+eD7kJjEpnQiVHGzYeT
         7mRldtzN7ldZHz+JnLoyosmYyTSpmVTCpgOiqrBEdAV604OT5uboDeclka3ubwAppPi6
         LwQbQxXJONW7ir0lVylqNDdYS/iSMb8bvum8gPzWNc2iX3JqNXReoKMHeEe7iPIyqMXI
         u5gA==
X-Gm-Message-State: APjAAAXHJPLxDmmOKKvWS6vKowkvasivDix+eG9Ob/THWZ7OkYukfjbO
        Iy7KjWgBcUDRk5ORT2HP6E8+dxnDCC2tYtCHdjts5edi
X-Google-Smtp-Source: APXvYqzvv3v7cPUhzsdmpGCcEIsgG5QjFMa2ND/saS7nnKWUwB2c2HRckRVxstcqJhfzBM2pu7jEpLWpM79ViJwvXsM=
X-Received: by 2002:a5d:9a04:: with SMTP id s4mr13551890iol.19.1561754038478;
 Fri, 28 Jun 2019 13:33:58 -0700 (PDT)
MIME-Version: 1.0
From:   TJ Corley <tjcorley30@gmail.com>
Date:   Fri, 28 Jun 2019 16:33:48 -0400
Message-ID: <CAHVEBDeOjt7LbMk=aP1QOzowtxvR+iLKgxM37bXTr=2GEhTu6w@mail.gmail.com>
Subject: Unable to call SCTP_ADD_STREAMS twice?
To:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

I am creating a library and it appears I am unable to call setsockopt
with the option SCTP_ADD_STREAMS on the same same socket twice. On the
second attempt it will return EINPROGRESS no matter what. It appears
this is happening due to the fact that
asoc->strreset_outstanding is still set. However if I am reading the
code correctly when I call the socket option sctp_send_reconf will be
called with a param of type SCTP_PARAM_RESET_ADD_OUT_STREAMS which
should eventually trigger the chain of  sctp_sf_do_reconf
->sctp_process_strreset_outreq which will decrement
asoc->strreset_outstanding.

I have SCTP_RECONFIG_SUPPORTED enabled and SCTP_ENABLE_RESET set to
SCTP_ENABLE_CHANGE_ASSOC_REQ | SCTP_ENABLE_RESET_STREAM_REQ |
SCTP_ENABLE_RESET_ASSOC_REQ on all the relevant sockets. Is there
anything else I should be doing?

I have included my sample code below that triggers this behavior.

Thanks for all the help,

TJ

#include <arpa/inet.h>
#include <errno.h>
#include <linux/sctp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/uio.h>
#include <unistd.h>

int allow_reconfigure_support(int fd) {
  struct sctp_assoc_value params;

  params.assoc_value = 1;
  params.assoc_id = 0;
  return setsockopt(fd, IPPROTO_SCTP, SCTP_RECONFIG_SUPPORTED, &params,
                    sizeof(params));
}

int allow_reset(int fd) {

  struct sctp_assoc_value params;

  params.assoc_id = 0;
  params.assoc_value = SCTP_ENABLE_CHANGE_ASSOC_REQ |
                       SCTP_ENABLE_RESET_STREAM_REQ |
                       SCTP_ENABLE_RESET_ASSOC_REQ;

  return setsockopt(fd, IPPROTO_SCTP, SCTP_ENABLE_STREAM_RESET, &params,
                    sizeof(params));
}

int add_streams(int fd, int num_streams) {

  struct sctp_add_streams addstr;
  addstr.sas_outstrms = num_streams;
  addstr.sas_instrms = 0x00;
  addstr.sas_assoc_id = 0;

  return setsockopt(fd, IPPROTO_SCTP, SCTP_ADD_STREAMS, &addstr,
                    sizeof(addstr));
}

int main() {
  struct sockaddr_in in, out;
  socklen_t out_len;
  int server;
  int client;
  int accept_fd;
  int err;
  memset(&in, '\x00', sizeof(in));

  in.sin_family = AF_INET;
  in.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
  in.sin_port = htons(12346);

  server = socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);
  client = socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);

  if (server == -1 || client == -1) {
    printf("socket(): %s\n", strerror(errno));
    return -1;
  }

  if (allow_reconfigure_support(server)) {
    printf("server allow_reconfigure_support: %s\n", strerror(errno));
  }

  if (allow_reset(client)) {
    printf("client allow_reset: %s\n", strerror(errno));
  }

  if (allow_reconfigure_support(client)) {
    printf("client allow_reconfigure_support: %s\n", strerror(errno));
  }

  if (allow_reset(client)) {
    printf("client allow_reset: %s\n", strerror(errno));
  }

  printf("server fd: %d\n", server);
  printf("client fd: %d\n", client);

  err = bind(server, (void *)&in, sizeof(in));
  if (err == -1) {
    printf("bind: %s\n", strerror(errno));
    return -1;
  }

  err = listen(server, 1);
  if (err == -1) {
    printf("listen: %s\n", strerror(errno));
    return -1;
  }

  err = connect(client, (void *)&in, sizeof(in));
  if (err == -1) {
    printf("connect: %s\n", strerror(errno));
    return -1;
  }

  accept_fd = accept(server, (void *)&out, &out_len);
  if (accept_fd == -1) {
    printf("accept: %s\n", strerror(errno));
    return -1;
  }
  printf("accept_fd: %d\n", accept_fd);

  if (allow_reconfigure_support(accept_fd)) {
    printf("accept_fd allow_reconfigure_support: %s\n", strerror(errno));
  }

  if (allow_reset(accept_fd)) {
    printf("accept_fd allow_reset: %s\n", strerror(errno));
  }

  err = add_streams(accept_fd, 0x10);
  if (err == -1) {
    printf("add_streams: %s\n", strerror(errno));
    return -1;
  }

  sleep(1);

  err = add_streams(accept_fd, 0x10);
  if (err == -1) {
    printf("add_streams2: %s\n", strerror(errno));
    return -1;
  }

  printf("finished no errors\n");
}
