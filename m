Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B6A5766EE
	for <lists+linux-sctp@lfdr.de>; Fri, 15 Jul 2022 20:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiGOStD (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 15 Jul 2022 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGOStC (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 15 Jul 2022 14:49:02 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0291150731
        for <linux-sctp@vger.kernel.org>; Fri, 15 Jul 2022 11:49:02 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id cb12-20020a056830618c00b00616b871cef3so4140639otb.5
        for <linux-sctp@vger.kernel.org>; Fri, 15 Jul 2022 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pHUPyZZJlgO57iDpzIJD9EJ4ejEuYmNIdskImsgqbM4=;
        b=BDKtrIjKJ2JOnZVQoqCad0i/ARLYE+72VxnCrrRT41a6fTfiAnPU4U0AOrqcnew3Sb
         enWO8DjFouGcLT5/71RGFWyzuYiLsmQVPjSSp4ZIGqBzHLeU+QPFllfkyiwnShkuahHu
         B13JwxYqQgZh6ocQ8ugUtwjIJIGQYplajH7+HpVLvfQNrwRCqQdC6XFU3ZavJLzbfPE+
         nZSOcImd7/H09+fnUSVxus7NBHZsarT2ANe25nvVeIpqe9So7WahW1jRxTmDJW/P0bml
         ROeCB0Z2nRUGrLjpP4mPY+WOnumsRFCgID4DJVUBcxNI5OAc8nSE+JvZ4tnqvS4GyR8U
         4g9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pHUPyZZJlgO57iDpzIJD9EJ4ejEuYmNIdskImsgqbM4=;
        b=v/8N3Zf3JwFd0fjU5645fdFiVeZYNP3ktay8QbceDiMj4j+02gBrKge54tfrBQ/AXv
         UMbGPStCMqwNvp4Bzs+wos72nBdiqus+CsG/pU7Mj6Skv4vr8k7lbdAXgRgsCErEKlUs
         HnMyJz7epnCs4MJ8rAmRyF6cyrpBcSJg3gav6b9A9DXx1DVpobvSMjweD5LF1/snJk0P
         TZsEjZJKNsSuLCUNmP9Ov2/ydc9m+6dPPcBC7SWw2OOQpws6jb8QpP3eeKvUzmhISH5A
         mzFqm4WoGywd0UyMTUxuuPTX9mT7DHOGo6LpCTLpn1NC5HPV8GtWn01QgtZf2KKBCJql
         ewZw==
X-Gm-Message-State: AJIora9Z7U+Y/kXIGYnrfmYXPkW2sJPq6o6Lmeb46bTmea5Y9R10FHiY
        Z0/c0s4lNchCER6doc26by7Qzu3qeOA=
X-Google-Smtp-Source: AGRyM1uUD+AADntW32VqH+rBOyXtSSbq03gJkagxO6rjfflARuz7I5zMMhq6CmgW4RHVRP1rq1j64A==
X-Received: by 2002:a9d:17e9:0:b0:61c:486c:79 with SMTP id j96-20020a9d17e9000000b0061c486c0079mr6070826otj.377.1657910941308;
        Fri, 15 Jul 2022 11:49:01 -0700 (PDT)
Received: from t14s.localdomain ([2001:1284:f016:fac3:cc74:75ab:960d:851a])
        by smtp.gmail.com with ESMTPSA id a25-20020a9d74d9000000b0061c7f73611asm1693784otl.60.2022.07.15.11.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 11:49:00 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id 54DA135A0D3; Fri, 15 Jul 2022 15:48:58 -0300 (-03)
Date:   Fri, 15 Jul 2022 15:48:58 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     o.evistel@free.fr
Cc:     linux-sctp <linux-sctp@vger.kernel.org>
Subject: Re: Linux SCTP performance question
Message-ID: <20220715184858.jnuam6rlhr44ehhw@t14s.localdomain>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net>
 <YsbiDrG1PQ2Gng5T@t14s.localdomain>
 <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Omar,

Both will end up sending the data with sendmsg(), but sctp_sendv()
will allow more flexibility. Unless you save some syscalls because of
it, performace wise it should be very similar.

Regards,
Marcelo

On Wed, Jul 13, 2022 at 02:58:40PM +0200, o.evistel@free.fr wrote:
> Dear Marcelo
> 
> I am using linux-sctp as transport for SIGTRAN M3UA on RHEL 8.4 and I am using sctp_sendmsg() and sctp_recvmsg() to send/receive.
> I would like to know if the use of sctp_sendv() and sctp_recvv() enhances performances ?
> 
> Regards
> Omar AIT AMRANE
> 
