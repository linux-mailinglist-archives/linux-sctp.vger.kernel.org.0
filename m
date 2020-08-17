Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E46E246798
	for <lists+linux-sctp@lfdr.de>; Mon, 17 Aug 2020 15:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgHQNpH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 17 Aug 2020 09:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgHQNpD (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 17 Aug 2020 09:45:03 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC3C061389;
        Mon, 17 Aug 2020 06:45:03 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k18so12357014qtm.10;
        Mon, 17 Aug 2020 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BYJ6ca7y4RKW7kdRQd9V6HMHJ7pUR25Ii4WZRZxcIwA=;
        b=jqBwkRXCUC2G9tzWrb6k8xJwhu64G95QxJ+276oiE+WfiVbbRP9Mcmt16c2SWy+X2y
         YMWGxufPGHwh4aa8WRz19RAZfhV1Yc7fJzjqdprRB4EQ4WTnBXCjLzwo/1jkL2r+ytlv
         Up5vZ1xlMeHGhDcUNrmnU1z9dqmRdNb3VYhVZgcgQLe1UGgf1wDIfl0RL7EzdJdPm8Ay
         ANX9YQHM4RtY8cwXrV/RcD2d3UpOHML3qRiWBqt7d5mxip+K93nHDHK87UVLkyI/HTxA
         4ewYk/HqUpw4M1nKUIRCoJ9/SQycMaHbmqpMW9Gb+z36MIW/zmOul+K9AFjxbCrLv4p4
         OiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BYJ6ca7y4RKW7kdRQd9V6HMHJ7pUR25Ii4WZRZxcIwA=;
        b=tDorWHX5P4mlijcZRUv3J8QFt0sFCPcrk5paVjlPNIhbf6y4AFh5JBs/Aan2rgcPBk
         1hH13Sr/yIoelzUTvutNVmy+sUql4PBNcXDBFjqkT575IdoPQbho+quZH9CNkEPYmq64
         tSVsN0TwTnZC6iQPGU/kUVyRYC+4RW1KQEYxkmmihyVZA3x0lti0xbDhUEaC9k3iQJoZ
         X2qWFqtvx0NU+xXutewknRhbof5zjs7LkYEofnQJF6zbQcH0wdydNmyfywIFItmXrd08
         /+sNVLoWs5owGiTt0DKmlHxDNLpgCGyEN99f2mNSHkqo+QDunJiyCxYO+GB0HZFFPQNc
         chPA==
X-Gm-Message-State: AOAM532LuiydQjv7SXvNc0xy9mXs7jr3Ohj9m5Qgf9Tk5tiTaFi+rFUr
        avGSTkZ5YOe3c0pdwVyDAk8=
X-Google-Smtp-Source: ABdhPJyVqyIxhKwzuWhEe9Z0A6G83FMUAjQN9TNfQx9T7rOXVPvoCVDoIVpCxe5GOOe0TAXHlptsKQ==
X-Received: by 2002:ac8:42ca:: with SMTP id g10mr13849675qtm.219.1597671901652;
        Mon, 17 Aug 2020 06:45:01 -0700 (PDT)
Received: from localhost.localdomain ([138.204.24.86])
        by smtp.gmail.com with ESMTPSA id j72sm17283270qke.20.2020.08.17.06.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 06:45:01 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 6E1CFC355F; Mon, 17 Aug 2020 10:44:57 -0300 (-03)
Date:   Mon, 17 Aug 2020 10:44:57 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     linux-sctp@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops on current Raspian when closing an SCTP connection
Message-ID: <20200817134457.GG3399@localhost.localdomain>
References: <20200816230624.GB2865@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200816230624.GB2865@minyard.net>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sun, Aug 16, 2020 at 06:06:24PM -0500, Corey Minyard wrote:
> I'm seeing the following when an SCTP connection terminates.  This is on
> Raspian on a Raspberry Pi, version is Linux version 5.4.51-v7+.  That's
> 32-bit ARM.
> 
> I haven't looked into it yet, I thought I would report before trying to
> chase anything down.  I'm not seeing it on 5.4 x86_64 systems.
> 
> Aug 16 17:59:00 access kernel: [510640.326415] Unable to handle kernel NULL pointer dereference at virtual address 00000008
> Aug 16 17:59:00 access kernel: [510640.341624] pgd = c00fc16c
> Aug 16 17:59:00 access kernel: [510640.347834] [00000008] *pgd=355ef835, *pte=00000000, *ppte=00000000
> Aug 16 17:59:00 access kernel: [510640.357731] Internal error: Oops: 17 [#22] SMP ARM
> Aug 16 17:59:01 access kernel: [510640.365931] Modules linked in: md5 sctp ftdi_sio cp210x usbserial raspberrypi_hwmon bcm2835_codec(C) v4l2_mem2mem bcm2835_isp(C) bcm2835_v4l2(C) bcm2835_mmal_vchiq(C) videobuf2_vmalloc videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 snd_bcm2835(C) videobuf2_common i2c_bcm2835 snd_pcm snd_timer videodev snd mc vc_sm_cma(C) uio_pdrv_genirq uio fixed nf_nat_pptp nf_conntrack_pptp nf_nat nf_conntrack nf_defrag_ipv4 rtc_ds1307 regmap_i2c i2c_dev ip_tables x_tables ipv6 nf_defrag_ipv6
> Aug 16 17:59:01 access kernel: [510640.425420] CPU: 1 PID: 4592 Comm: gtlsshd Tainted: G      D  C        5.4.51-v7+ #1327
> Aug 16 17:59:01 access kernel: [510640.438008] Hardware name: BCM2835
> Aug 16 17:59:01 access kernel: [510640.443823] PC is at sctp_ulpevent_free+0x38/0xa0 [sctp]
> Aug 16 17:59:01 access kernel: [510640.451498] LR is at sctp_queue_purge_ulpevents+0x34/0x50 [sctp]

Not ringing a bell here. Can you pinpoint on which line this crash
was? It seems, by the 0x8 offset and these function offsets, that this
could be when it was trying to access event->rmem_len, but if event
was NULL then it should have crashed earlier.

  Marcelo
