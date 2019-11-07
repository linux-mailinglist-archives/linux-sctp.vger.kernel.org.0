Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C02F2E1C
	for <lists+linux-sctp@lfdr.de>; Thu,  7 Nov 2019 13:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKGMXH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 7 Nov 2019 07:23:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33947 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfKGMXH (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 7 Nov 2019 07:23:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id 205so1784139qkk.1
        for <linux-sctp@vger.kernel.org>; Thu, 07 Nov 2019 04:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KyG7DBmig0r0orERL1phFbSXuklTlpO4lxLEaoKxsiU=;
        b=XoYHQGajBGhtg9p8VY+UxyQdyqYXxp8eYdx53rtXAFEgA+xZRFg6baLgPv71r7Qk5l
         VvNhDWyLCyOF9QSMsMyycyD5byIMar6IEMnSMXXFPQgfhV5RpDdqRovyQfrraRrKo6aI
         Es4hlPxlQ+j3tKHERnBki/ImwlgH7nDmik0gByaKSsxNJlGzTQSVQ6JGwaCbeeo+g1Kp
         oZZPGwOLwZVIwJOp9bJphfw0Zcr71sxkGUxllioMgs3Fwvj4DT4KZwgznivPrw/v9GkG
         TkWdaVzmOUDVc5bTlYzxyJ6u7iAf6OcFaLXN7cBx0Y9KdwhNO6L/Z1oExYIQeST4RRak
         wkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KyG7DBmig0r0orERL1phFbSXuklTlpO4lxLEaoKxsiU=;
        b=foaA2yXDqi9IPVO4RpJmAUH7sTRcxFezXAYJEMuEtw7ecxosY1caCrFjzapPeMcTTK
         oa8fyboh3X2MrGPwvU9cs4pXifzTwLnkKBvf01zR0tnRQ+O34FkVPk2ahGhZGBWYErZi
         5Dyym+HDhAenUeQnyGZgIQcP3oY9xRv/EqeXCA3yRXll1iMsXcosaQ+39GrsMuYEUq7f
         XlIMDdZqlS6o2lqUDpwB5EonIbho/B65hKlTtVRHFUhMZRjlaeA5DI0qUN4pIVjVbBrM
         pVs5CA6TTepduZVCHGXb6djd8e5CQobHct9XRqEQ7i1EGfL6zOsTznOoMOgMw/NANFim
         ar4A==
X-Gm-Message-State: APjAAAUxS8Ncd/CW5WlX5hirV2thCM04d1GqLp6jNlYEPxhmgneID/cY
        EVu4B1upWFnl4bbqJg/0fDO87A37K4s=
X-Google-Smtp-Source: APXvYqySZabs0cO9QDdOsLYP6twM4U+up/msK1E7sNriDalKC8FgCz0IOIViZuuOof6JysAUtkJKgA==
X-Received: by 2002:a37:4904:: with SMTP id w4mr2299533qka.119.1573129386001;
        Thu, 07 Nov 2019 04:23:06 -0800 (PST)
Received: from localhost.localdomain ([168.181.48.201])
        by smtp.gmail.com with ESMTPSA id a19sm1221240qtk.56.2019.11.07.04.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 04:23:05 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 359B3C3AB5; Thu,  7 Nov 2019 09:23:02 -0300 (-03)
Date:   Thu, 7 Nov 2019 09:23:02 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        linux-sctp@vger.kernel.org, paul@afk.ro
Subject: Re: Fw: [Bug 205439] New: SCTP responds to heartbeat from the wrong
 address / interface
Message-ID: <20191107122302.GA3420@localhost.localdomain>
References: <20191105073925.58ff6518@hermes.lan>
 <20191105214511.GB27571@hmswarspite.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191105214511.GB27571@hmswarspite.think-freely.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Cc'ing bz reporter.

On Tue, Nov 05, 2019 at 04:45:11PM -0500, Neil Horman wrote:
> On Tue, Nov 05, 2019 at 07:39:25AM -0800, Stephen Hemminger wrote:
> > 
> > 
> > Begin forwarded message:
> > 
> > Date: Tue, 05 Nov 2019 11:59:05 +0000
> > From: bugzilla-daemon@bugzilla.kernel.org
> > To: stephen@networkplumber.org
> > Subject: [Bug 205439] New: SCTP responds to heartbeat from the wrong address / interface
> > 
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=205439
> > 
> >             Bug ID: 205439
> >            Summary: SCTP responds to heartbeat from the wrong address /
> >                     interface
> >            Product: Networking
> >            Version: 2.5
> >     Kernel Version: 4.9.35-server
> >           Hardware: Intel
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: high
> >           Priority: P1
> >          Component: Other
> >           Assignee: stephen@networkplumber.org
> >           Reporter: paul@afk.ro
> >         Regression: No
> > 
> > Seems that SCTP responds to heartbeat from the wrong address / interface.
> > 
> > # netstat -nS | fgrep 162.93.39.
> > sctp       0      0 81.226.10.66:3561     162.93.39.198:3561      ESTABLISHED
> >                     81.226.10.70          162.93.39.194
> > sctp       0      0 81.226.10.66:3560     162.93.39.134:3560      ESTABLISHED
> >                     81.226.10.70          162.93.39.130
> > 
> > Bad:
> >     3   0.055267 162.93.39.130 → 185.226.110.70 SCTP 74 HEARTBEAT
> >     4   0.055291 81.226.10.66 → 162.93.39.130 SCTP 74 HEARTBEAT_ACK
> >     7   0.355746 162.93.39.194 → 185.226.110.70 SCTP 74 HEARTBEAT
> >     8   0.355758 81.226.10.66 → 162.93.39.194 SCTP 74 HEARTBEAT_ACK
> > 
> > Good:
> >    13   0.551876 162.93.39.134 → 81.226.10.66 SCTP 74 HEARTBEAT
> >    14   0.551906 81.226.10.66 → 162.93.39.134 SCTP 74 HEARTBEAT_ACK
> >    19   0.853376 162.93.39.198 → 81.226.10.66 SCTP 74 HEARTBEAT
> >    20   0.853388 81.226.10.66 → 162.93.39.198 SCTP 74 HEARTBEAT_ACK
> > 
> > 
> > This is multi-homed scenario of SCTP.
> > 
> > Regards,
> > 
> According to the RFC:
> https://tools.ietf.org/html/rfc4960#page-38
> In section 3.3.6, theres no guarantee that a HEARTBEAT_ACK will be sent
> from the same address that the HEARTBEAT chunk was received on, only
> that it will be sent back to the same address that generated the
> HEARTBEAT, which both cases above are doing.
> 
> If you want to guarantee source address selection in addition to the
> destination address guarantee, I think you need to set up your routing
> tables such that the source address to the given destination is
> specified.
> 
> We could probably change that to guarantee source address selection, but
> I'm not sure thats a universally desired feature.
> 
> Best
> Neil
> 
> > -- 
> > You are receiving this mail because:
> > You are the assignee for the bug.
> > 
> 
