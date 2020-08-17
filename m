Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3551E247180
	for <lists+linux-sctp@lfdr.de>; Mon, 17 Aug 2020 20:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390626AbgHQS3O (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 17 Aug 2020 14:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390778AbgHQS2u (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 17 Aug 2020 14:28:50 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141E6C061389;
        Mon, 17 Aug 2020 11:28:50 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o21so15612660oie.12;
        Mon, 17 Aug 2020 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6X353itaXkDHqSu22DPUW9j+w4AM7wyuUFGnVJQkvAg=;
        b=k+axQxniUoUpFPhsKqdJdzpEsffqb1QGFrUCpyDdCwhH88nu9mlsHCZCYYE0np5mJ1
         dbQfAQOv0N8ewztEhdItGY/P5gewbqdoON3Q10CgE1iHacG6Zv5nhtgcDlFNyUtAuw9y
         pFsARcBVw3aFJcKyR4GGr9NtzC+3TI+QD1QaRvHR31wSd140Br6Lwq2PjkqZ/H6qqlR+
         4IAUrCjJKYl9dWdPc7TPB+KGnbtm15EZRCD6gzWjwt3PAtCWiKdbet4jaKFsvhTi85zY
         5/62RbvsqZD27qs3mFUq9fv4Cp9hVp/CR57l1IxobdWPa7uBMXo4O7WXlwi2fVd8GPmM
         xP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=6X353itaXkDHqSu22DPUW9j+w4AM7wyuUFGnVJQkvAg=;
        b=bDMxlMENimA6mAykrx+zhxgj0CAO6U8pII6YfJfLiUNELN3cEhQ8brdjslOCSwKd8G
         Qf+vySil1yWe8nUc0+ogSsBTPvQO22Xp4+EoF5sIU0h5F3SqxN+t7yBgS5Bh/yvT/ngD
         gOdiJH40dDeul35OpDq6HEyVc2OpUKIiRQIg7qOg9FZUj4RTIl3nD49epC7lhVr/3uW+
         PKIFYlqB9R3X416hwJ3q+Uo4n3ffMPuAH6ty7ybuigcc+wQRM9Okq/oh9pYSrbcOneOs
         uWcOortnQmIlnRYOVxmZsN5xM9OydQ9/DKv5TgBBlwJw1z4C6FMghRpwwZbkz7b0Uy+Z
         tt7A==
X-Gm-Message-State: AOAM531V2HaAA/eayjywoLShzHqCCJKvuo+M6cAJuSiqehBWmTtrZmvu
        AucjRFRvfBUi+dIBxiJcKZU1iwCEOHCt
X-Google-Smtp-Source: ABdhPJx8V3+mgbwyP0s7nmLtLka6xMXS+0k2A0rB405LRR1V/jD5ENfDHllxosLiWTOfKm9xaxUbPw==
X-Received: by 2002:aca:b286:: with SMTP id b128mr10608019oif.89.1597688928014;
        Mon, 17 Aug 2020 11:28:48 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
        by smtp.gmail.com with ESMTPSA id l17sm3547047otn.2.2020.08.17.11.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 11:28:46 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id 8C4C9180043;
        Mon, 17 Aug 2020 18:28:45 +0000 (UTC)
Date:   Mon, 17 Aug 2020 13:28:44 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops on current Raspian when closing an SCTP connection
Message-ID: <20200817182844.GZ2842@minyard.net>
Reply-To: minyard@acm.org
References: <20200816230624.GB2865@minyard.net>
 <20200817134457.GG3399@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817134457.GG3399@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Aug 17, 2020 at 10:44:57AM -0300, Marcelo Ricardo Leitner wrote:
> On Sun, Aug 16, 2020 at 06:06:24PM -0500, Corey Minyard wrote:
> > I'm seeing the following when an SCTP connection terminates.  This is on
> > Raspian on a Raspberry Pi, version is Linux version 5.4.51-v7+.  That's
> > 32-bit ARM.
> > 
> > I haven't looked into it yet, I thought I would report before trying to
> > chase anything down.  I'm not seeing it on 5.4 x86_64 systems.
> > 
> > Aug 16 17:59:01 access kernel: [510640.438008] Hardware name: BCM2835
> > Aug 16 17:59:01 access kernel: [510640.443823] PC is at sctp_ulpevent_free+0x38/0xa0 [sctp]
> > Aug 16 17:59:01 access kernel: [510640.451498] LR is at sctp_queue_purge_ulpevents+0x34/0x50 [sctp]
> 
> Not ringing a bell here. Can you pinpoint on which line this crash
> was? It seems, by the 0x8 offset and these function offsets, that this
> could be when it was trying to access event->rmem_len, but if event
> was NULL then it should have crashed earlier.
> 
>   Marcelo

I think so:

00015e38 <sctp_ulpevent_free>:
   15e38:       e1a0c00d        mov     ip, sp
   15e3c:       e92dd878        push    {r3, r4, r5, r6, fp, ip, lr, pc}
   15e40:       e24cb004        sub     fp, ip, #4
   15e44:       e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
   15e48:       ebfffffe        bl      0 <__gnu_mcount_nc>

ulpevent.c:1102		if (sctp_ulpevent_is_notification(event))
   15e4c:       e1d032f0        ldrsh   r3, [r0, #32]
   15e50:       e1a05000        mov     r5, r0
   15e54:       e3530000        cmp     r3, #0
   15e58:       ba000011        blt     15ea4 <sctp_ulpevent_free+0x6c>

This is the false branch from the above (high bit isn't set).

ulpevent.c:1061		if (!skb->data_len) (just the fetch part)
   15e5c:       e5903040        ldr     r3, [r0, #64]   ; 0x40

ulpevent.c:1059		len = skb->len;
   15e60:       e590603c        ldr     r6, [r0, #60]   ; 0x3c

ulpevent.c:1061         if (!skb->data_len) (the compare part)
   15e64:       e3530000        cmp     r3, #0
   15e68:       0a000008        beq     15e90 <sctp_ulpevent_free+0x58>


ulpevent.c:1065		skb_walk_frags(skb, frag) {
skbuff.h:1395		return skb->end; (inside skb_shinfo())
   15e6c:       e5903084        ldr     r3, [r0, #132]  ; 0x84

skbuff.h:3461		iter = skb_shinfo(skb)->frag_list
   15e70:       e5934008        ldr     r4, [r3, #8] <-- Crash occurs here

   15e74:       e3540000        cmp     r4, #0
   15e78:       0a000004        beq     15e90 <sctp_ulpevent_free+0x58>
   15e7c:       e2840018        add     r0, r4, #24
   15e80:       ebfffa34        bl      14758 <sctp_ulpevent_release_frag_data>


So it appears that skb->end is NULL.

-corey
