Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9C3207CF3
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jun 2020 22:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgFXUba (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 24 Jun 2020 16:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgFXUb3 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Jun 2020 16:31:29 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A65DC061573;
        Wed, 24 Jun 2020 13:31:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r22so3167775qke.13;
        Wed, 24 Jun 2020 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P+8CNlZ9Qpc5ZgQ40v352IfRPP/wLIfYxQwvpVM2BK8=;
        b=kk7RsrcZrq+EWEq1RkGL2qELTGIfWZ+7A5f8uxNPVPEibrKo6usG/U0X0c/K+WQBaK
         I0Vwu1ij+04Cm4N7N3hudYLfDj4vowAhndJiBzYXBiACSt71ZxTEXRs6VcfVL0KDPyjR
         H5dwoZ2YW2q6AHbmuSGodnv9tfTkh+oXgN0UtmZW0NQBaFPV78w3U6SbYtPkS+0iSm+g
         rnrzLxXzGuGRRRpHjzVX3PNAKgAJ+sgg24MjZrzAWiniIlFI/d+6rlJnYP3HKvOhAG5v
         cIAaii2PEC3/5lT+LK9jL2EzJ1WsYy12heloFZpwlSbpRJmdZcTlTK1cquFc+jfo0O0J
         A8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P+8CNlZ9Qpc5ZgQ40v352IfRPP/wLIfYxQwvpVM2BK8=;
        b=s3oHTi3mDFAoU+7V0fWbyBH0xa8p+EdYilSaPLOEGvcnFjuq4kTjgBiNoX2XDTDs13
         wYniwaQXuDreXHSP/4HsJVFdGscSCHtSEmv4ekkMApundTOsvZyg7TZEpBrv7LOB7AbP
         qTwJG1Pppu4mV8vFg4NEgQq8d6IkxE6yi9QwWMBdQK0ndSKsZ+vYzuukUEQq9BEhzEBX
         TurVWpUheaP/3uCpURhiaOlv3CttEGM2QWSp2RjBnh3j4PonBW0lBNIMIh0jqwkFA7YJ
         3iGBVGPJf/H8wb4Ce6DCC45JLeKhJOAQyPmU4eRmzLMJf3iBOlq/3lmPgv26nUuM6E5D
         rZAg==
X-Gm-Message-State: AOAM532aizxMmseNUW71i8mcWi9NhS2l+gIehJ2dYArDxAuASn8iAXNO
        SNXiirbXtslUE8ejqhyJ4l5pLMmW
X-Google-Smtp-Source: ABdhPJxFGJjPPJsul4HY8UXD+hfA7PTPvAdjeGqHA32bUhuExyZhqZvYUt5TGM9WxXxqkE8f8Hufew==
X-Received: by 2002:a05:620a:15da:: with SMTP id o26mr24463049qkm.304.1593030687577;
        Wed, 24 Jun 2020 13:31:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f016:65e9:974:aec1:b314:98ea])
        by smtp.gmail.com with ESMTPSA id p7sm3647794qki.61.2020.06.24.13.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 13:31:26 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id E8370C3123; Wed, 24 Jun 2020 17:31:23 -0300 (-03)
Date:   Wed, 24 Jun 2020 17:31:23 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     minyard@acm.org
Cc:     Xin Long <lucien.xin@gmail.com>,
        Michael Tuexen <Michael.Tuexen@lurchi.franken.de>,
        Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] sctp: Don't advertise IPv4 addresses if ipv6only is set
 on the socket
Message-ID: <20200624203123.GC47547@localhost.localdomain>
References: <c1121947c9a94703b4ab6dc434a7c3f8@AcuMS.aculab.com>
 <20200623160417.12418-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623160417.12418-1-minyard@acm.org>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Jun 23, 2020 at 11:04:17AM -0500, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> If a socket was set ipv6only, it would still send IPv4 addresses in the
> init and init ack packets.  So don't add IPv4 addresses to ipv6only
> sockets.
> 
> Based on a patch by Xin Long <lucien.xin@gmail.com>
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
> I have tested this and it seem to fix the issue.  However, I'm wondering
> if it might be better to fix it where the addresses are put into the
> association as opposed to where they are put into the message.

Yes, it is. It even highlights why this issue was there in the first
place. Sending a patch right after this email.

  Marcelo
