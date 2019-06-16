Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7DA47645
	for <lists+linux-sctp@lfdr.de>; Sun, 16 Jun 2019 19:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfFPR4S (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 16 Jun 2019 13:56:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33977 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfFPR4S (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 16 Jun 2019 13:56:18 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so16509025iot.1
        for <linux-sctp@vger.kernel.org>; Sun, 16 Jun 2019 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=dD2/6Ac6jkvmYP2E4som2WQCZwIGFy+8PnZd91D6NVw=;
        b=dIUSbvC3BHHQJ+vAGrUrC0BVc6JvtSUpeKFEKZ2s8yg2Clov7UiRuk7HnQ9rPAVJCV
         XGrg/YVoq3c8Mx/FaAdQQw5wCRqVjrTn+mFPpSsizH1LJwTHTKO94Mha9SY3ttxjaC1y
         edeu+qIAU0CRRArk2qbvpTs0940/hQVNFlY3czpfvP3j/QXrKHlINexbGFWTa+6bGYds
         JsuoxxHZEx2quG+AgqtZ3HUANvzCxTLT3lhgExgl4fuhlAm7/i5IR8IZJtCh47/XH96+
         U0H4D4xcEvLq17CHXyJBJ8+h03Mh26Zkoa5CCwUlquaYs5z81CsKDTjSVIkRMlQaEx6g
         WMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dD2/6Ac6jkvmYP2E4som2WQCZwIGFy+8PnZd91D6NVw=;
        b=k4f+cLd1Wr5HdQgb/fPGB7bKcugCgjXWJCIVB7gkSpu3tUzh8NcYIH7RQZLHQFQo0w
         XZAjFquGf/iZNoI+iz8BcdoSh2gn/D5e4u20r++/9o+CT0FzAWLdKftOZkrDYUW1gCqR
         LGX6B/U25BDGD99QMCKqb0sA2D4LPN7b+XJkghrKk5CbXLGFPnvt++O4LT7QvOpEUcCG
         SnxbkdWStinIP0RKIL00QmUar+RLNDxC2Ft6D+jWFFQv3UamQjQA5sNxuwPuEZC0J68g
         UQCTMPzG5OTdSfh3fXdBCfddnkrevJYCdAVVM3Bju4kgAq6bKxnI+t7dmsXqFMlqhNSV
         gZ2w==
X-Gm-Message-State: APjAAAX+H95FoSk6AN9L9vu+A5qaJCHLMBtsJpGd0/dulBR+RkBgoLtx
        fqyXuIUlBKAE+xyWb6GEDFqD47PH6HfYQHesU5qNhmCXJMQ=
X-Google-Smtp-Source: APXvYqyjEnZYSwdQnQdDPoi8tPwVJSeBQz7H9EqsoeWOnNxpcxutRIuE+mcRsy87k3Bsypv3xla+HvGEwkU6NS/Do9k=
X-Received: by 2002:a02:16:: with SMTP id 22mr38661038jaa.131.1560707777046;
 Sun, 16 Jun 2019 10:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <e863ee11-9e1f-71b9-1f61-b4b71d9f0945@elstel.org>
In-Reply-To: <e863ee11-9e1f-71b9-1f61-b4b71d9f0945@elstel.org>
From:   malc <mlashley@gmail.com>
Date:   Sun, 16 Jun 2019 18:56:06 +0100
Message-ID: <CAPkQJpRMFuF=hYyVNAcfzhkzaVAUwnsSfMW7KGffsa=c1tkirw@mail.gmail.com>
Subject: Re: sctp_sendmsg does not accept flags
To:     Linux SCTP <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

I think you want 'man 3 sctp_sendmsg' [1] and one of the flags
supported there... namely SCTP_UNORDERED. SCTP_ADDR_OVER, SCTP_ABORT,
SCTP_EOF
See also [2] which I'm guessing is relevant to what you're /trying/ to achieve.

Cheers,
malc.

[1] https://linux.die.net/man/3/sctp_sendmsg
[2] https://sourceforge.net/p/lksctp/mailman/message/11557899/


On Sun, Jun 16, 2019 at 2:40 PM Elmar Stellnberger <estellnb@elstel.org> wrote:
>
>     While sctp_send works well at me, sctp_sendmsg gives me an EINVAL as
> soon as I pass in some flags. Nonetheless it still sends the message in
> spite of returning the EINVAL. That looks like an error to me. Please
> investigate the issue.
>
> while( len > 0 && ( ( ret = sctp_sendmsg( sid, bufp, len, NULL, 0, 0,
> MSG_NOSIGNAL, (0), 1000, 0 ) ) >= 0 || ( ret==-1 && ( errno == EINTR ||
> errno == ENOBUFS ) ) ) ) {  // returns EINVAL if flags are passed
>      if( ret >= 0 ) { bufp += ret; len -= ret; } else if( errno ==
> ENOBUFS ) { struct timespec ts; ts.tv_sec=0; ts.tv_nsec=10000;
> nanosleep(&ts,NULL); } }
> if( ret == -1 ) perror ("error sending request to stream #(0)");
>
>    If you should be interested I can send the whole sctp test client
> program.
>
>
>
>
>
>
