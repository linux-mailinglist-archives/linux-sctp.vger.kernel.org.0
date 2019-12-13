Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F85611DBF6
	for <lists+linux-sctp@lfdr.de>; Fri, 13 Dec 2019 03:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbfLMCFD (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 12 Dec 2019 21:05:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35651 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731864AbfLMCFD (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 12 Dec 2019 21:05:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so744482pgk.2
        for <linux-sctp@vger.kernel.org>; Thu, 12 Dec 2019 18:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=XFE2WEqPww9hrPNTlokFg1ydsJkJIBHmKFrj5jVK8wg=;
        b=LKyCIPEJOLjuL9eQqy/wHrbHSOXbMz4oMIAxi0+piXyWSjiZXwsDQkhHbSd5dtq5G+
         Z0JAEL2XD8/1tCjZ4aof81Ib4dc7JyZpLEZCQ+G4jvHQJgUkCRf4RqHyIwhymTAAzMTZ
         PAm4fj0fcSpdf12R8RdaXgXWONgog2zq9H9vDsOIwRA5JcyEEV5qdHRXPAXC6CDct6Y1
         DMJE/RyFeYJr2JNyiQ9sdF/ycEdYWqX82DM2Y9DtLQKjrMxGoiItuuBBJF0PF6M3y1Sv
         sSn/VJ9nFQHh7jrKQzviNHD5qU2PQ9XsFPCs5nviG0dL1FD2ky7SZ9LCQYzr/R7yuFVg
         3/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=XFE2WEqPww9hrPNTlokFg1ydsJkJIBHmKFrj5jVK8wg=;
        b=dwSwxX/Nks7sCprneoKOaLrcdL/9h+iS4IPHksb30y7TS8dWSLXdq5+RVoCUzM2gAo
         Drkvgg7CHQUkpSc+lXDOdQnEFdZ1p5BZQ8YNDmX22ulDnhNbE0vCdBYkRWe+wNubxlAO
         P7L9aNDHxk55186yTNwQZ7XW82ohjIL4HIXfy29XcawNYbEh7QvB/LhRbVrDbnAhceEB
         +FqGsc3eqSQ07b+FI/9IhC5Ln1Rxj/Y69+5q2Zct//zbkHhx78B54Gf3ulWnSPU4WtcB
         wkiznvkeevtq1TNyzW1miCPaYe2cC1InrpI3r+PWfziqKluMRy1tnQ7dcyiBuMI0zHjl
         fBoQ==
X-Gm-Message-State: APjAAAUjmADDC8/IOiG6PGacYZ4sPY3XlL74xHpAhTrAqokoVmHuV9Ls
        pjaofY3SxgnQMuGUD1tXAPQptw==
X-Google-Smtp-Source: APXvYqxejyDVM4mfG2SLpJhjeTv7BcxPUUI/HLA766KLgOJAt/nt7lz82x7KBEJgyGkHLEIFiSrSEA==
X-Received: by 2002:a63:d041:: with SMTP id s1mr14379047pgi.363.1576202702817;
        Thu, 12 Dec 2019 18:05:02 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id p186sm8734108pfp.56.2019.12.12.18.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 18:05:02 -0800 (PST)
Date:   Thu, 12 Dec 2019 18:04:59 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     subashab@codeaurora.org
Cc:     Lorenzo Colitti <lorenzo@google.com>,
        Maciej =?UTF-8?B?xbtlbmN6eWtv?= =?UTF-8?B?d3NraQ==?= 
        <zenczykowski@gmail.com>, "David S . Miller" <davem@davemloft.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Sean Tranchetti <stranche@codeaurora.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux SCTP <linux-sctp@vger.kernel.org>
Subject: Re: [PATCH v2] net: introduce ip_local_unbindable_ports sysctl
Message-ID: <20191212180459.687adf9c@cakuba.netronome.com>
In-Reply-To: <2e7ceea704ee71383d3f19d1de63dff4@codeaurora.org>
References: <CAHo-OowKQPQj9UhjCND5SmTOergBXMHtEctJA_T0SKLO5yebSg@mail.gmail.com>
        <20191209224530.156283-1-zenczykowski@gmail.com>
        <20191209154216.7e19e0c0@cakuba.netronome.com>
        <CANP3RGe8zqa2V-PBjvACAJa2Hrd8z7BXUkks0KCrAtyeDjbsYw@mail.gmail.com>
        <20191209161835.7c455fc0@cakuba.netronome.com>
        <CAHo-OowHek4i9Pzxn96u8U5sTH8keQmi-yMCY-OBS7CE74OGNQ@mail.gmail.com>
        <20191210093111.7f1ad05d@cakuba.netronome.com>
        <CAKD1Yr05=sRDTefSP6bmb-VvvDLe9=xUtAF0q3+rn8=U9UjPcA@mail.gmail.com>
        <20191212164749.4e4c8a4c@cakuba.netronome.com>
        <CAKD1Yr1V4S3cxvTaBs6pReEZ_3LPobnxdroY+vE3-injHyGt2A@mail.gmail.com>
        <2e7ceea704ee71383d3f19d1de63dff4@codeaurora.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, 12 Dec 2019 18:53:19 -0700, subashab@codeaurora.org wrote:
> On 2019-12-12 17:57, Lorenzo Colitti wrote:
> > On Fri, Dec 13, 2019 at 9:47 AM Jakub Kicinski wrote:  
> >> How are the ports which get reserved communicated between the baseband
> >> and the AP? Is this part of the standard? Is the driver that talks to
> >> the base band in the user space and it knows which ports to reserve
> >> statically? Or does the modem dynamically request ports to
> >> reserve/inform the host of ports in use?  
> > 
> > I'm not an expert in that part of the system, but my understanding is
> > that the primary way this is used is to pre-allocate a block of ports
> > to be used by the modem on boot, before other applications can bind to
> > ports. Subash, do you have more details?  
> 
> AFAIK these ports are randomly picked and not from a standard.
> Userspace gets this information through qrtr during boot.
> 
> Atleast in our case, there cannot be any existing user of these ports
> since these ports are blocked prior to mobile connection establishment.

Not even a listening socket?

> We could call SOCK_DIAG_DESTROY on these ports from userspace as a
> precaution as applications would gracefully handle the socket errors.

Right, or kernel could walk them, since presumably every application
using this functionality should do it, anyway? But no strong feeling 
on this if nobody else feels this is needed.
